using blog.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using System.Security;

using PagedList;
using PagedList.Mvc;

namespace blog.Controllers
{
    public class HomeController : Controller
    {
        BlogDB db = new BlogDB();
        Veritabani veri = new Veritabani();

        // GET: Home
        public ActionResult Index()
        {
            List<tblPosts> post = db.tblPosts.OrderByDescending(x => x.EklenmeTarihi).ToList();
            return View(post);
        }

        public ActionResult Blog(string search)
        {
            List<tblPosts> list;
            if (string.IsNullOrEmpty(search) || string.IsNullOrWhiteSpace(search))
            {
                list = db.tblPosts.OrderByDescending(x => x.EklenmeTarihi).Take(6).ToList();
            }
            else
            {
                list = db.tblPosts.Where(x => x.Baslik.Contains(search) || x.Icerik.Contains(search)).OrderByDescending(x => x.EklenmeTarihi).ToList();
            }

            return View(list);
        }

        public ActionResult KategoriFiltre(int? id)
        {
            List<tblPosts> list = db.tblPosts.Where(x => x.KategoriId == id).ToList();
            ViewBag.Kategori = db.tblKategoriler.ToList();
            return View(list);
        }

        public ActionResult BlogDetay(int? id)
        {
            if (id == null)
            {
                RedirectToAction("Index");
            }

            var list = db.tblPosts.Where(x => x.PostId == id).SingleOrDefault();
            if (list == null)
                return RedirectToAction("Index");

            ViewBag.Yorumlar = db.tblYorumlar.Where(x => x.PostId == id);

            return View(list);
        }

        public JsonResult YorumYap(string Yorum, int postId)
        {
            if (Yorum.Trim() != null)
            {
                db.tblYorumlar.Add(new tblYorumlar { YazarId = int.Parse(Request.Cookies["User"]["YazarId"]), PostId = postId, Yorum = Yorum, YorumETarihi = DateTime.Now });
                db.SaveChanges();
            }
            return Json(false, JsonRequestBehavior.AllowGet);
        }

        public PartialViewResult KategoriGetir()
        {
            return PartialView(db.tblKategoriler.ToList());
        }

        public PartialViewResult EtiketGetir()
        {
            return PartialView(db.tblEtiket.Take(10).ToList());
        }

        public PartialViewResult SonPostGetir()
        {
            return PartialView(db.tblPosts.OrderByDescending(x => x.EklenmeTarihi).Take(3).ToList());
        }

        public PartialViewResult Arama()
        {
            return PartialView();
        }

        public ActionResult NotFound()
        {
            return View();
        }

        public ActionResult MailGonder(string mailAdres)
        {
            string mailIcerik = "<b>Öncelikle bloğumuza abone girip göz attığınız için <i>teşekkürler</i>. Yepyeni haberleri okumanız dileğiyle iyi günler dileriz.</b>";
            veri.MailGonderme(mailAdres, "cihan.celen37@hotmail.com", "", "CihanCelenBlog Haber İletisi", mailIcerik, "smtp.live.com");
            return RedirectToAction("Index");
        }
        
        public ActionResult VeriGetir()
        {
            return View();
        }

        [HttpPost]
        public ActionResult VeriGetir(int id)
        {
            List<tblPosts> list = db.tblPosts.Where(x => x.PostId < id).Take(6).OrderByDescending(x => x.PostId).ToList();
            return View(list);
        }

    }
}