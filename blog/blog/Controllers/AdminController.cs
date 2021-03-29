using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using blog.Models;
using System.Collections;
using System.Web.Helpers;
using System.IO;

namespace blog.Controllers
{
    public class AdminController : Controller
    {
        BlogDB db = new BlogDB();

        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult PostEkle()
        {
            ViewBag.Kategori = db.tblKategoriler;
            ViewBag.Etiket = db.tblEtiket.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult PostEkle(tblPosts post, string Etiket, HttpPostedFileBase PostResimUrl)
        {
            if (string.IsNullOrEmpty(post.Baslik) || string.IsNullOrEmpty(post.Aciklama) || string.IsNullOrEmpty(post.Icerik) || string.IsNullOrEmpty(Etiket))
            {
                ViewBag.Hata = "swal('Post eklenemedi.','Gerekli tüm alanları doldurunuz.', 'error');";
                ViewBag.Kategori = db.tblKategoriler.ToList();
                ViewBag.Etiket = db.tblEtiket.ToList();
                return View();
            }
            else
            {
                string[] etiketler = Etiket.Split(',', ' ', '-');

                foreach (var item in etiketler)
                {
                    var yeniEtiket = new tblEtiket { Etiket = item };
                    db.tblEtiket.Add(yeniEtiket);
                    post.tblEtiket.Add(yeniEtiket);
                }

                if (ModelState.IsValid)
                {
                    if (PostResimUrl != null)
                    {
                        WebImage img = new WebImage(PostResimUrl.InputStream);
                        FileInfo fotoinfo = new FileInfo(PostResimUrl.FileName);
                        string newFoto = Guid.NewGuid().ToString() + fotoinfo.Extension;
                        img.Resize(1280, 720);
                        img.Save("~/Uploads/PostImages/" + newFoto);
                        post.PostResimUrl = "/Uploads/PostImages/" + newFoto;
                    }
                }

                post.YazarId = int.Parse(Request.Cookies["User"]["YazarId"]);
                post.EklenmeTarihi = DateTime.Now;
                db.tblPosts.Add(post);

                db.SaveChanges();
                return RedirectToAction("Postlar");
            }
        }

        public ActionResult Uyeler()
        {
            return View(db.tblYazarlar.OrderByDescending(x => x.KayitTarihi).ToList());
        }

        public ActionResult Yazarlar()
        {
            return View(db.tblYazarlar.Where(x => x.RutbeId == db.tblRutbe.Where(y => y.Rutbe == "yazar").FirstOrDefault().RutbeId).OrderByDescending(x => x.KayitTarihi).ToList());
        }

        public ActionResult Postlar()
        {
            return View(db.tblPosts.OrderByDescending(x => x.EklenmeTarihi).ToList());
        }

        [HttpPost]
        public void PostSil(int id)
        {
            tblPosts p = db.tblPosts.Where(x => x.PostId == id).FirstOrDefault();

            foreach (var item in p.tblEtiket.ToList())
            {
                db.tblEtiket.Remove(item);
            }
            foreach (var item in p.tblYorumlar.ToList())
            {
                db.tblYorumlar.Remove(item);
            }

            db.tblPosts.Remove(p);
            db.SaveChanges();
        }

        [HttpPost]
        public void UyeSil(int id)
        {
            tblYazarlar y = db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault();

            foreach (var item in y.tblPosts.ToList())
            {
                db.tblPosts.Remove(item);
            }
            foreach (var item in y.tblYorumlar.ToList())
            {
                db.tblYorumlar.Remove(item);
            }

            db.tblYazarlar.Remove(y);
            db.SaveChanges();
        }

        [HttpPost]
        public void YazarOnayla(int id)
        {
            db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault().RutbeId = db.tblRutbe.Where(x => x.Rutbe == "yazar").SingleOrDefault().RutbeId;
            db.SaveChanges();
        }

        [HttpPost]
        public void UyeYap(int id)
        {
            db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault().RutbeId = db.tblRutbe.Where(x => x.Rutbe == "üye").SingleOrDefault().RutbeId;
            db.SaveChanges();
        }

    }
}