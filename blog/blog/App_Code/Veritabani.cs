using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace blog
{
    public class Veritabani
    {
        /*Mail Gonderme*/
        public void MailGonderme(string gonderilecek, string gonderen, string gonderenParola, string mailBaslik, string mailIcerik, string host)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(gonderen);
            mail.IsBodyHtml = true;
            mail.To.Add(gonderilecek);
            mail.Subject = mailBaslik;
            mail.Body = mailIcerik;
            SmtpClient smtp = new SmtpClient();
            smtp.Credentials = new NetworkCredential(gonderen, gonderenParola);
            smtp.Port = 587;
            smtp.Host = host;
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }

        /*Uniq Id*/
        public string GetUniqID()
        {
            var ts = (DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0));
            double t = ts.TotalMilliseconds / 1000;

            int a = (int)Math.Floor(t);
            int b = (int)((t - Math.Floor(t)) * 1000000);

            return a.ToString("x8") + b.ToString("x5");
        }


    }
}