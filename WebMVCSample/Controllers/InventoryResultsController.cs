using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using WebInventory.Models;
using WebInventory.Common;
using WebInventory.ViewModels;
using System.Collections.Generic;
using WebInventory.Filters;
using System.IO;
using System.Web.Script.Serialization;

namespace WebInventory.Controllers
{
    public class InventoryResultsController : Controller
    {
        //
        // GET: /InventoryResults/
        [ValidateUserAttribute]
        public ActionResult Index()
        {
            Session["MainData"] = null;
            Session["MainTotals"] = null;
            ViewBag.ActionMethod = "GetInventory";
            return View();
        }

        [HttpPost]
        [ValidateUser]
        public JsonResult GetInventory(JQueryDataTableParamModel param)
        {
            param = param ?? new JQueryDataTableParamModel();

            InventoryModel invModel = new InventoryModel();
            DataTable invDataTable = null;

            string searchParams = Convert.ToString(Session["searchQuery"]);

            if (Session["MainData"] == null)
            {
                invDataTable = invModel.GetResults(Convert.ToString(Session["ClientCd"]), searchParams);
                Session["MainData"] = invDataTable;
            }
            else
            {
                invDataTable = (DataTable)Session["MainData"];
            }

            var invPageData = invDataTable.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var invResults = invPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            //var invPageSum = (from k in invPageData.AsEnumerable()
            //                  group k by new { } into r
            //                  select new
            //                  {
            //                      cts = r.Sum(v => v.Field<decimal>("CTS")),
            //                      amt = r.Sum(v => v.Field<decimal>("ASKAMT_FC")),
            //                      rate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")), r.Sum(v => v.Field<decimal>("CTS")), 2),
            //                      raprate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("RAPAAMT")), r.Sum(v => v.Field<decimal>("CTS")), 2),
            //                      disc = 100 - ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")) * 100, r.Sum(v => v.Field<decimal>("RAPAAMT")), 2),
            //                  }).FirstOrDefault();

            InvnTotals invGrandSum = new InvnTotals();
            if (Session["MainTotals"] == null)
            {
                invGrandSum = (from k in invDataTable.AsEnumerable()
                               group k by new { } into r
                               select new InvnTotals
                               {
                                   Cts = r.Sum(v => v.Field<decimal>("CTS")),
                                   Amount = r.Sum(v => v.Field<decimal>("ASKAMT_FC")),
                                   Rate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")), r.Sum(v => v.Field<decimal>("CTS")), 2),
                                   Rrate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("RAPAAMT")), r.Sum(v => v.Field<decimal>("CTS")), 2),
                                   Disc = 100 - ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")) * 100, r.Sum(v => v.Field<decimal>("RAPAAMT")), 2),
                               }).FirstOrDefault();
                Session["MainTotals"] = invGrandSum;
            }
            else
            {
                invGrandSum = (InvnTotals)Session["MainTotals"];
            }

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = invDataTable.Rows.Count,
                iTotalDisplayRecords = invDataTable.Rows.Count,
                aaData = invResults,
                //ipTotals = invPageSum,
                igTotals = invGrandSum,
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExportExcel()
        {
            //Response.Clear();
            //Response.ContentType = "application/force-download";
            //Response.AddHeader("content-disposition", "attachment;    filename=results.xlsx");
            //Response.BinaryWrite(excelBytes);
            //Response.End();

            HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];
            return File(GetDataBytes(reqCookie), System.Net.Mime.MediaTypeNames.Application.Octet, "results.xlsx");

            //return View("Index");
        }

        [HttpPost]
        [ValidateUserAttribute]
        public JsonResult InvMail(MailContentsVM mailContents)
        {
            string msgBody = ComFunc.ReadHtml("SearchResults.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                .Replace("`IP-Address`", Convert.ToString(Session["curRequestIp"])).Replace("`Url`", Request.Url.ToString().RootUrl())
                .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));

            HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];

            int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, null, mailContents.Subject, msgBody, null, GetDataBytes(reqCookie));
            return Json(retval, JsonRequestBehavior.AllowGet);
        }

        [NonAction]
        private byte[] GetDataBytes(HttpCookie reqCookie)
        {
            InventoryModel invModel = new InventoryModel();
            DataTable invDataTable = null;
            if (Session["MainData"] == null)
            {
                invDataTable = invModel.GetResults(Convert.ToString(Session["ClientCd"]));
                Session["MainData"] = invDataTable;
            }
            else
            {
                invDataTable = (DataTable)Session["MainData"];
            }

            string[] selectedRefno = null;

            if (reqCookie != null)
                selectedRefno = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            string[] selectedColumns = new[] { "CERTIFICATE", "CERTINO", "STONEID", "SHAPE", "CTS", "COLOR", "CLARITY", "CUT", "POLISH", "SYM", "RAPARATE", "ASKRATE_FC", "ASKDISC_FC", "ASKAMT_FC", "FLOURENCE", "DEPTH", "DIATABLE", "MEASUREMENT", "GIRDLEPER" };

            DataTable selectedData;
            if (selectedRefno != null)
            {
                DataTable curTable = invDataTable.AsEnumerable()
                                     .Where(c => selectedRefno.Contains(c.Field<string>("STONEID"))).CopyToDataTable();

                selectedData = new DataView(curTable).ToTable(false, selectedColumns);
            }
            else
            {
                selectedData = new DataView(invDataTable).ToTable(false, selectedColumns);
            }

            return ExcelExporter.GenerateReport(selectedData, "InventoryResults");
        }

        [HttpPost]
        [ValidateUserAttribute]
        public JsonResult ModifySearch()
        {
            return Json(@Url.Action("Index", "InventorySearch"), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateUserAttribute]
        public JsonResult NewSearch()
        {
            Session["dicSearchParams"] = null;
            return Json(@Url.Action("Index", "InventorySearch"), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateUserAttribute]
        [ActionName("AddCart")]
        public ActionResult AddCart_Post()
        {
            /* I- stands for shopping cart Cart status */
            string res = ShoppingCart("I");

            return Json(new { retUrl = Url.Action("MyCart", "InventoryCart"), title = "Add to Cart", msg = res });
        }

        [HttpPost]
        [ValidateUserAttribute]
        [ActionName("AddBuyRequest")]
        public ActionResult AddBuyRequest()
        {
            /* B- stands for shopping cart Buy Request status */
            string res = ShoppingCart("B");

            return Json(new { retUrl = Url.Action("MyBuyRequest", "InventoryCart"), title = "Add to Buy Request", msg = res });
        }

        [NonAction]
        private string ShoppingCart(string cartType)
        {
            string vClientCd = Convert.ToString(Session["Clientcd"]);
            string vStatus = cartType;

            List<string> ClientCart = ClientInventory.GetClientCart(vClientCd, vStatus);

            HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];

            string retRefNo = "";

            if (reqCookie != null)
            {
                List<string> selectedCart = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                var duplicates = selectedCart.Intersect(ClientCart).ToList();

                var validCartRefno = selectedCart.Except(ClientCart).ToList();

                if (validCartRefno.Count > 0)
                {
                    retRefNo = ClientInventory.InsertCart(vClientCd, vStatus, string.Join(",", validCartRefno.ToArray()), 0, 0);

                    if (cartType == "B")
                    {
                        MailContentsVM mailContents = new MailContentsVM();

                        mailContents.To = Convert.ToString(Session["Emailid"]);
                        //mailContents.Bcc = WebSiteSettings.Global_InfoMail;
                        mailContents.Subject = "Your buy requests @ " + WebSiteSettings.Global_Website;
                        mailContents.Message = "";

                        string msgBody = ComFunc.ReadHtml("SearchResults.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                           .Replace("`IP-Address`", Convert.ToString(Session["curRequestIp"])).Replace("`Url`", Request.Url.ToString().RootUrl())
                           .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                           .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));

                        int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, null, mailContents.Subject, msgBody, null, GetDataBytes(reqCookie));
                    }

                    if (cartType == "I")
                        retRefNo = "Request has been added to your cart..";
                    else
                        retRefNo = "Request has been added to your Buy Now cart..";
                }
                else
                {
                    if (duplicates.Count > 3)
                        retRefNo = string.Join(",", duplicates.Take(3).ToList());
                    else
                        retRefNo = string.Join(",", duplicates.ToList());

                    if (cartType == "I")
                        retRefNo = retRefNo + "... found in your cart..";
                    else
                        retRefNo = retRefNo + "... found in your Buy Now cart..";
                }
            }
            return retRefNo;
        }

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult CompareStones()
        {
            string reqtagId = Request.QueryString["tg"] == null ? "" : Request.QueryString["tg"];
            if (reqtagId == "")
                return View();
            else
            {
                HttpCookie reqCookie = Request.Cookies[reqtagId];
                return CompareDetails(reqCookie);
            }
        }

        [HttpPost]
        [ActionName("CompareStones")]
        [ValidateUserAttribute]
        public ActionResult CompareStones_Post()
        {
            HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];
            return CompareDetails(reqCookie);
        }

        private ActionResult CompareDetails(HttpCookie reqCookie)
        {
            if (reqCookie != null)
            {
                List<string> selectedStones = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                DataTable invDataTable = null;

                if (Session["MainData"] != null)
                {
                    invDataTable = (DataTable)Session["MainData"];
                }

                string[] selectedColumns = new[] { "STONEID", "CERTIFICATE", "CERTNO", "CTS", "COLOR", "CLARITY", "CUT", "POLISH", "SYM", "FLOURENCE", 
                     "RAPARATE", "ASKRATE_FC", "ASKDISC_FC", "DEPTH", "DIATABLE", "MEASUREMENT", "GIRDLEPER", "CULET", "INSCRIPTION",
                     "DIA", "HA", "INCLUSION", "CROWN", "CROWNANGLE", "CROWNHEIGHT", "PAVILION", "PAVANGLE", "PAVHEIGHT", "STAR_LENGTH",
                     "LOWER_HALF", "LUSTER", "MILKY", "SHADE", "NATTS", "NATURAL", "PAIR", "KEY_TO_SYMBOL", "REPORT_COMMENT"
                    };

                DataTable selectedData;
                if (selectedStones != null)
                {
                    DataTable curTable = invDataTable.AsEnumerable()
                                         .Where(c => selectedStones.Contains(c.Field<string>("STONEID"))).CopyToDataTable();

                    selectedData = new DataView(curTable).ToTable(false, selectedColumns);

                    var compareStones = selectedData.AsEnumerable().Select(dr => dr.ItemArray.Select(data => Convert.ToString(data)).ToArray()).ToList();

                    return Json(new { aaData = compareStones }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(null);
                }
            }
            return Json(null);
        }

        [ValidateUserAttribute]
        public ActionResult CompareExcel()
        {
            if (Session["CompareExcel"] != null)
            {
                Byte[] StreamBytes = Session["CompareExcel"] as Byte[];
                Session["CompareExcel"] = null;
                return File(StreamBytes, System.Net.Mime.MediaTypeNames.Application.Octet, string.Format("StockCompare@{0}.xlsx", WebSiteSettings.Global_Website));
            }
            return new EmptyResult();
        }

        [HttpPost]
        [ActionName("CompareExcel")]
        public ActionResult CompareExcelExport(string refnos)
        {
            if (string.IsNullOrEmpty(refnos))
                return null;
            else
            {
                HttpCookie reqCookie = new HttpCookie("Compare", refnos);

                Session["CompareExcel"] = GetDataBytes(reqCookie);

                //return File(GetDataBytes(reqCookie), System.Net.Mime.MediaTypeNames.Application.Octet, string.Format("StockCompare@{0}.xlsx", WebSiteSettings.Global_Website));

                return Json(new { status = 200 }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [ValidateUserAttribute]
        public JsonResult CompareStockMail(MailContentsVM mailContents, string refnos)
        {
            string msgBody = ComFunc.ReadHtml("SearchResults.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                .Replace("`IP-Address`", Convert.ToString(Session["curRequestIp"])).Replace("`Url`", Request.Url.ToString().RootUrl())
                .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));

            HttpCookie reqCookie = new HttpCookie("Compare", refnos);

            int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, null, mailContents.Subject, msgBody, null, GetDataBytes(reqCookie));
            Session["CompareMailExcel"] = null;
            return Json(retval, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult StoneDetail(string id)
        {
            return View();
        }

        [HttpPost]
        [ActionName("StoneDetail")]
        [ValidateUserAttribute]
        public ActionResult StoneDetail_Post()
        {
            InventoryModel invModel = new InventoryModel();
            DataTable invDataTable = null;
            string searchParams = string.Empty;

            if (Request.Url.Segments.Length > 3)
                searchParams = Request.Url.Segments[3];
            else
                return new EmptyResult();

            invDataTable = invModel.GetResults(Convert.ToString(Session["ClientCd"]), " AND STONEID = '" + searchParams + "'");

            var refNoDetails = invDataTable.AsEnumerable().Select(dr => dr.ItemArray.Select(data => Convert.ToString(data)).ToArray()).ToList();

            var clLinks = hlinks(invDataTable);

            return Json(new { aaData = refNoDetails, refLinks = clLinks }, JsonRequestBehavior.AllowGet);
        }

        private Dictionary<string, string> hlinks(DataTable data)
        {
            Dictionary<string, string> dets = new Dictionary<string, string>();
            DataRow dr = data.Select().FirstOrDefault();
            string refno = Convert.ToString(dr["STONEID"]);
            string certtype = Convert.ToString(dr["CERTIFICATE"]);
            string certnO = Convert.ToString(dr["CERTINO"]);
            string cts = Convert.ToString(dr["CTS"]);
            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/diams/digital/" + refno + ".jpg")))
            {
                dets.Add("digital", "../../images/StockImg/diams/digital/" + refno + ".jpg");
                //dets.Add("digthmb", "../../content/images/thumbnail/diams/digital/" + refno + ".jpg");
            }
            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/diams/Asset/" + refno + ".jpg")))
            {
                dets.Add("Asset", "../../images/StockImg/diams/Asset/" + refno + ".jpg");
                //dets.Add("Assetthmb", "../../content/images/thumbnail/diams/Asset/" + refno + ".jpg");
            }
            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/diams/Ideal/" + refno + ".jpg")))
            {
                dets.Add("Ideal", "../../images/StockImg/diams/Ideal/" + refno + ".jpg");
                //dets.Add("Idealthmb", "../../content/images/thumbnail/diams/Ideal/" + refno + ".jpg");
            }
            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/diams/Heart/" + refno + ".jpg")))
            {
                dets.Add("Heart", "../../images/StockImg/diams/Heart/" + refno + ".jpg");
                //dets.Add("Heartthmb", "../../content/images/thumbnail/diams/Heart/" + refno + ".jpg");
            }
            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/diams/Arrow/" + refno + ".jpg")))
            {
                dets.Add("Arrow", "../../images/StockImg/diams/Arrow/" + refno + ".jpg");
                //dets.Add("Arrowthmb", "../../content/images/thumbnail/diams/Arrow/" + refno + ".jpg");
            }

            string certurl = string.Empty;
            switch (certtype.ToUpper())
            {
                case "GIA": certurl = "http://www.gia.edu/cs/Satellite?reportno=" + certnO + "&childpagename=GIA%2FPage%2FReportCheck&pagename=GIA%2FDispatcher&c=Page&cid=1355954554547'"; break;
                case "IGI": certurl = "http://www.igiworldwide.com/verify.php?r=" + certnO; break;
                case "HRD": certurl = "https://my.hrdantwerp.com/?record_number=" + certnO + "&weight=" + cts + "&L='"; break;
                default: certurl = ""; break;
            }

            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/certs/" + refno + ".jpg")))
            {
                dets.Add("Cert", "../../images/StockImg/certs/" + refno + ".jpg");
            }

            if (System.IO.File.Exists(Server.MapPath("~/images/StockImg/video/" + refno + ".mp4")))
            {
                dets.Add("Video", "../../images/StockImg/video/" + refno + ".mp4");
            }

            dets.Add("verifyCert", certurl);

            return dets;
        }

        //[HttpPost]
        //public JsonResult SelectedStock(JQueryDataTableParamModel param)
        //{
        //    param = param ?? new JQueryDataTableParamModel();

        //    InventoryModel invModel = new InventoryModel();
        //    DataTable invDataTable = null;

        //    HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];
        //    if (reqCookie != null)
        //    {
        //        List<string> selectedStones = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
        //        if (Session["MainData"] != null)
        //        {
        //            invDataTable = (DataTable)Session["MainData"];
        //        }

        //        DataTable selectedDT;

        //        if (selectedStones != null)
        //        {
        //            DataTable curTable = invDataTable.AsEnumerable()
        //                                 .Where(c => selectedStones.Contains(c.Field<string>("STONEID"))).CopyToDataTable();

        //            selectedDT = new DataView(curTable).ToTable();

        //            var selectedData = selectedDT.AsEnumerable().Select(dr => dr.ItemArray.Select(data => Convert.ToString(data)).ToArray()).ToList();

        //            return Json(new
        //            {
        //                sEcho = param.sEcho,
        //                iTotalRecords = invDataTable.Rows.Count,
        //                iTotalDisplayRecords = invDataTable.Rows.Count,
        //                aaData = invResults,
        //                igTotals = invGrandSum,
        //            }, JsonRequestBehavior.AllowGet);
        //        }
        //        else
        //        {
        //            return Json(null);
        //        }
        //    }
        //    else
        //    {

        //    }

        //    InvnTotals invGrandSum = new InvnTotals();
        //    if (Session["MainTotals"] == null)
        //    {
        //        invGrandSum = (from k in invDataTable.AsEnumerable()
        //                       group k by new { } into r
        //                       select new InvnTotals
        //                       {
        //                           Cts = r.Sum(v => v.Field<decimal>("CTS")),
        //                           Amount = r.Sum(v => v.Field<decimal>("ASKAMT_FC")),
        //                           Rate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")), r.Sum(v => v.Field<decimal>("CTS")), 2),
        //                           Rrate = ComFunc.mydivide(r.Sum(v => v.Field<decimal>("RAPAAMT")), r.Sum(v => v.Field<decimal>("CTS")), 2),
        //                           Disc = 100 - ComFunc.mydivide(r.Sum(v => v.Field<decimal>("ASKAMT_FC")) * 100, r.Sum(v => v.Field<decimal>("RAPAAMT")), 2),
        //                       }).FirstOrDefault();
        //        Session["MainTotals"] = invGrandSum;
        //    }
        //    else
        //    {
        //        invGrandSum = (InvnTotals)Session["MainTotals"];
        //    }


        //}
    }
}