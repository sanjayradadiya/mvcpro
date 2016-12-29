using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Net;
using System.IO;

namespace WebInventory.Common
{
    public static class SendMail
    {
        public static int sendMailWithAuthentication(string strFrom, string strto, string strcc, string strBcc, string strSubject, string strBody, string strAttach, byte[] streamAttach = null)
        {
            try
            {
                MailMessage Msg = new MailMessage();

                if (string.IsNullOrEmpty(strFrom))
                {
                    strFrom = "info@mothergems.in";
                }

                //Mail from
                Msg.From = new MailAddress(strFrom);

                //Mail to 
                if (!string.IsNullOrEmpty(strto))
                {
                    List<string> mailsTo = strto.Replace(";", ",").Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                    foreach (var vstrTo in mailsTo)
                    {
                        Msg.To.Add(new MailAddress(vstrTo));
                    }
                }

                //MailCc
                if (!string.IsNullOrEmpty(strcc))
                {
                    if (!string.IsNullOrEmpty(strcc.Replace(";", ",")))
                    {
                        Msg.CC.Add(strcc);
                    }
                }

                //MailBcc
                if (!string.IsNullOrEmpty(strBcc))
                {
                    if (!string.IsNullOrEmpty(strBcc = strBcc.Replace(";", ",")))
                    {
                        Msg.Bcc.Add(strBcc);
                    }
                }

                Msg.Subject = strSubject;
                Msg.IsBodyHtml = true;
                Msg.Body = strBody;

                if (!string.IsNullOrEmpty(strAttach))
                {
                    Msg.Attachments.Add(new Attachment(HttpContext.Current.Server.MapPath(strAttach)));
                }

                if (streamAttach != null)
                {
                    using (MemoryStream mstream = new MemoryStream(streamAttach))
                    {
                        Msg.Attachments.Add(new Attachment(mstream, string.Format("Results-{0}.xlsx", DateTime.Now.ToString().Replace("/", "_").Replace(":", "_"))));
                        int flag = Msg.SendingMail();
                        mstream.Flush();
                        return flag;
                    }
                }

                return Msg.SendingMail();
            }
            catch (Exception)
            {
                return (0);
            }
        }

        private static int SendingMail(this MailMessage msg)
        {
            try
            {
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "mail.mothergems.in";
                smtp.Port = 587;
                smtp.Timeout = 200000;
                smtp.Credentials = new NetworkCredential("demomails@mothergems.in", "DemoMail_11");
                smtp.Send(msg);

                msg.Attachments.Dispose();
                msg.Dispose();
                msg = null;

                return 1;
            }
            catch (Exception)
            {
                return 0;
            }
        }

    }
}