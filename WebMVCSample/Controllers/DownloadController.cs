using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebInventory.ViewModels;

namespace WebInventory.Controllers
{
    public class DownloadController : Controller
    {
        //
        // GET: /Download/

        [ActionName("DownloadContent")]
        public ActionResult DownloadFile(string refCd, string fileName)
        {
            if (Session[refCd] != null)
            {
                byte[] data = Session[refCd] as byte[];
                return File(data, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
            }
            else
            {
                return new EmptyResult();
            }
        }

        [HttpPost]
        public ActionResult DownloadContent(string req, string filetype)
        {
            if (!string.IsNullOrEmpty(req))
            {
                string filePath = string.Empty;
                filetype = filetype.ToLower();
                switch (filetype)
                {
                    case "img": filePath = Server.MapPath("~/Images/StockImg/diams/"); break;
                    case "certi": filePath = FilePaths()["Certi"]; break;
                    case "video": filePath = FilePaths()["Video"]; break;
                    case "all": filePath = FilePaths()["All"]; break;
                }

                return ContentDownloader(filePath, req, filetype);

                //return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
            }
            return new EmptyResult();
        }

        private JsonResult ContentDownloader(string filePath, string refNo, string contentType)
        {
            string handle = Guid.NewGuid().ToString(); string fileName = string.Empty;
            string[] singleFiletypes = { "video", "certi" };
            if (singleFiletypes.Contains(contentType))
            {
                fileName = refNo + ".jpg";
                if (System.IO.File.Exists(filePath + fileName))
                {
                    byte[] fileBytes = System.IO.File.ReadAllBytes(filePath + fileName);
                    using (MemoryStream memoryStream = new MemoryStream(fileBytes))
                    {
                        Session[handle] = memoryStream.ToArray();
                    }

                    return new JsonResult()
                    {
                        Data = new { refCd = handle, FileName = fileName, respUrl = @Url.Action("DownloadContent", "Download") }
                    };
                }
            }
            else
            {
                Dictionary<string, string> imgDictFiles = FilePaths();
                List<string> imgFilePaths = new List<string>();

                imgFilePaths.Add(imgDictFiles["imgDigital"]);
                imgFilePaths.Add(imgDictFiles["imgArrow"]);
                imgFilePaths.Add(imgDictFiles["imgAsset"]);
                imgFilePaths.Add(imgDictFiles["imgIdeal"]);
                imgFilePaths.Add(imgDictFiles["imgHeart"]);

                if (contentType != "img")
                {
                    imgFilePaths.Add(imgDictFiles["Certi"]);
                    imgFilePaths.Add(imgDictFiles["Video"]);
                }

                using (ZipFile zip = new ZipFile())
                {
                    string FolderNm = WebSiteSettings.Global_Website + refNo;

                    //List<string> outFiles = new List<string>();
                    foreach (string imgPath in imgFilePaths)
                    {
                        string fnm = string.Empty;
                        if (!imgPath.ToLower().Contains("video"))
                            fnm = imgPath + refNo + ".jpg";
                        else
                            fnm = imgPath + refNo + ".mp4";

                        string imgNm = imgPath.Split(new char[] { '\\' }).Reverse().Skip(1).Take(1).ToList()[0];
                        if (System.IO.File.Exists(fnm))
                        {
                            //outFiles.Add(fnm);
                            zip.AddFile(fnm).FileName = imgNm + "_" + Path.GetFileName(fnm);
                        }
                    }
                    //zip.AddFiles(outFiles, false, FolderNm);
                    var memStream = new MemoryStream();
                    zip.Save(memStream);

                    Session[handle] = memStream.ToArray();

                    memStream.Close();
                    memStream.Dispose();

                    return new JsonResult()
                    {
                        Data = new { refCd = handle, FileName = FolderNm + ".zip", respUrl = @Url.Action("DownloadContent", "Download") }
                    };
                }
            }
            return new JsonResult();
        }

        private Dictionary<string, string> FilePaths()
        {
            Dictionary<string, string> filePaths = new Dictionary<string, string>();

            filePaths.Add("imgDigital", Server.MapPath("~/Images/StockImg/diams/digital/"));
            filePaths.Add("imgArrow", Server.MapPath("~/Images/StockImg/diams/Arrow/"));
            filePaths.Add("imgAsset", Server.MapPath("~/Images/StockImg/diams/Asset/"));
            filePaths.Add("imgIdeal", Server.MapPath("~/Images/StockImg/diams/Ideal/"));
            filePaths.Add("imgHeart", Server.MapPath("~/Images/StockImg/diams/Heart/"));
            filePaths.Add("Video", Server.MapPath("~/Images/StockImg/Video/"));
            filePaths.Add("Certi", Server.MapPath("~/Images/StockImg/Certs/"));

            return filePaths;
        }

    }
}