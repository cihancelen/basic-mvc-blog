using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using blog.Models;
using System.Web.Helpers;
using System.IO;

namespace blog.Controllers
{
    public class UyeController : Controller
    {
        BlogDB db = new BlogDB();
        Veritabani veri = new Veritabani();

        public ActionResult KayitOl()
        {
            return View();
        }

        [HttpPost]
        public ActionResult KayitOl(tblYazarlar yazar, string ParolaTekrar)
        {
            var isYazar = db.tblYazarlar.Where(x => x.KullaniciAdi == yazar.KullaniciAdi || x.Email == yazar.Email).SingleOrDefault();
            if (isYazar != null)
            {
                ViewBag.Hata = "swal('Var olan kullanıcı.','" + yazar.KullaniciAdi + " / " + yazar.Email + " adında bir kayıt zaten bulunuyor.', 'warning');";
                return View();
            }
            else if (yazar.Parola.ToString().Length < 7 || yazar.Parola.ToString().Length > 20)
            {
                ViewBag.Hata = "swal('Parola uzunluğu','Parola uzunluğu 7 karakterden az 20 karakterden fazla olamaz.', 'warning');";
                return View();
            }
            else if (yazar.Parola != ParolaTekrar)
            {
                ViewBag.Hata = "swal('Parolalar uyuşmuyor.','Formu doldururken alanları uygun şekilde doldurunuz.', 'error');";
                return View();
            }
            else
            {
                yazar.Parola = Crypto.Hash(yazar.Parola, "MD5");
                /*Default profil resmi*/
                yazar.AvatarResim = "/Uploads/images/default.png";
                yazar.KayitTarihi = DateTime.Now;
                yazar.RutbeId = 1;
                yazar.YazarOnay = false;
                yazar.AktivasyonKodu = Crypto.Hash(veri.GetUniqID(), "MD5");
                db.tblYazarlar.Add(yazar);
                db.SaveChanges();

                veri.MailGonderme(yazar.Email, "cihan.celen37@hotmail.com", "", "cihancelenBlog | Aktivasyon Maili", "Aktivasyon için <a href='localhost:52449/Uye/YazarOnayla/" + yazar.AktivasyonKodu + "'>tıklayınız</a>.", "smtp.live.com");

                HttpCookie cookie = new HttpCookie("User");
                cookie.Expires = DateTime.Now.AddDays(7);
                cookie.HttpOnly = true;

                cookie.Values["YazarId"] = yazar.YazarId.ToString();
                cookie.Values["YazarKulAdi"] = yazar.KullaniciAdi.ToString();
                cookie.Values["Email"] = yazar.Email.ToString();
                cookie.Values["RutbeId"] = yazar.RutbeId.ToString();

                Response.Cookies.Add(cookie);

                return RedirectToAction("Index", "Home");
            }
        }

        public ActionResult Giris()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Giris(string username, string pass)
        {
            var uye = db.tblYazarlar.Where(x => x.KullaniciAdi == username || x.Email == username).SingleOrDefault();
            if (uye == null)
            {
                ViewBag.Hata = "swal('Kullanıcı bulunamadı.','" + username.ToString() + " adında bir kullanıcı adı veya email bulunamadı.', 'error');";
                return View();
            }

            if ((uye.KullaniciAdi == username || uye.Email == username) && uye.Parola == Crypto.Hash(pass, "MD5"))
            {
                HttpCookie cookie = new HttpCookie("User");
                cookie.Expires = DateTime.Now.AddDays(7);
                cookie.HttpOnly = true;

                cookie.Values["YazarId"] = uye.YazarId.ToString();
                cookie.Values["YazarKulAdi"] = uye.KullaniciAdi.ToString();
                cookie.Values["Email"] = uye.Email.ToString();
                cookie.Values["RutbeId"] = uye.RutbeId.ToString();

                Response.Cookies.Add(cookie);

                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Hata = "swal('Beklenmedik Hata', 'Lütfen kullanıcı adı, mail yada parolanızı doğru girdiğinizden emin olunuz.', 'error');";
                return View();
            }
        }

        public ActionResult Cikis()
        {
            if (Request.Cookies["User"] != null)
            {
                Response.Cookies["User"].Expires = DateTime.Now.AddDays(-7);
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Profil()
        {
            if (Request.Cookies["User"] == null)
                return RedirectToAction("Index", "Home");
            else
            {
                int id = int.Parse(Request.Cookies["User"]["YazarId"]);
                return View(db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault());
            }
        }

        [HttpPost]
        public string Profil(string parola)
        {
            int id = int.Parse(Request.Cookies["User"]["YazarId"]);
            db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault().Parola = Crypto.Hash(parola, "MD5");
            int a = db.SaveChanges();
            if (a > 0)
            {
                return "s";
            }
            else
            {
                return "f";
            }
        }

        [HttpPost]
        public ActionResult ProfilResimGuncelle(HttpPostedFileBase AvatarResim)
        {
            if (ModelState.IsValid)
            {
                if (AvatarResim != null)
                {
                    WebImage img = new WebImage(AvatarResim.InputStream);
                    FileInfo info = new FileInfo(AvatarResim.FileName);
                    string newFoto = Guid.NewGuid().ToString() + info.Extension;
                    img.Save("~/Uploads/images/" + newFoto);
                    int id = int.Parse(Request.Cookies["User"]["YazarId"]);
                    db.tblYazarlar.Where(x => x.YazarId == id).FirstOrDefault().AvatarResim = "/Uploads/images/" + newFoto;
                    db.SaveChanges();
                }
            }
            return RedirectToAction("Profil");
        }

        public ActionResult YazarOnayla(string aktivasyonKodu)
        {
            if (aktivasyonKodu != null)
                return View();

            var yazar = db.tblYazarlar.Where(x => x.AktivasyonKodu == aktivasyonKodu).FirstOrDefault();
            if (yazar != null)
            {
                ViewBag.Durum = "Başarılı";
                ViewBag.Aciklama = "Tebrik ederiz aktivasyon işlemi başarılı.";
                yazar.AktivasyonKodu = "";
                yazar.YazarOnay = true;
                db.SaveChanges();
            }
            else
            {
                ViewBag.Durum = "Başarısız";
                ViewBag.Aciklama = "Bu aktivasyon linki daha önce kullanılmış.";
            }

            return View();
        }

    }
}