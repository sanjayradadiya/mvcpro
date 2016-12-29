using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebInventory.Common;
using WebInventory.Filters;
using WebInventory.Models;
using WebInventory.ViewModels;

namespace WebInventory.Controllers
{
    public class InventoryCartController : Controller
    {
        //
        // GET: /InventoryCart/
        /*--------------------------------------------------------------View My Cart*/
        [ActionName("MyCart")]
        [ValidateUserAttribute]
        public ActionResult Index()
        {
            Session["MainCartData"] = null;
            ViewBag.ActionMethod = "MyCart";
            return View();
        }

        [HttpPost]
        [ActionName("MyCart")]
        [ValidateUserAttribute]
        public JsonResult Index(JQueryDataTableParamModel param)
        {
            param = param ?? new JQueryDataTableParamModel();

            InventoryModel invModel = new InventoryModel();
            DataTable invDataTable = null;

            string searchParams = Convert.ToString(Session["whereCartParams"]);

            if (Session["MainCartData"] == null)
            {
                invDataTable = invModel.GetCartByClientCD(Convert.ToString(Session["Clientcd"]), "I", searchParams);
                Session["MainCartData"] = invDataTable;
            }
            else
            {
                invDataTable = (DataTable)Session["MainCartData"];
            }

            var invPageData = invDataTable.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var invResults = invPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            InvnTotals invGrandSum = new InvnTotals();
            if (Session["MainCartTotals"] == null)
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
                Session["MainCartTotals"] = invGrandSum;
            }
            else
            {
                invGrandSum = (InvnTotals)Session["MainCartTotals"];
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


        /*--------------------------------------------------------------View My BuyRequest*/
        [ValidateUserAttribute]
        [ActionName("MyBuyRequest")]
        public ActionResult BuyRequests()
        {
            Session["MainBuyReqData"] = null;
            ViewBag.ActionMethod = "MyBuyRequest";
            return View();
        }

        [HttpPost]
        [ValidateUserAttribute]
        [ActionName("MyBuyRequest")]
        public JsonResult BuyRequests(JQueryDataTableParamModel param)
        {
            param = param ?? new JQueryDataTableParamModel();

            InventoryModel invModel = new InventoryModel();
            DataTable invDataTable = null;

            string searchParams = Convert.ToString(Session["whereBuyNowParams"]);

            if (Session["MainBuyReqData"] == null)
            {
                invDataTable = invModel.GetCartByClientCD(Convert.ToString(Session["Clientcd"]), "B", searchParams);
                Session["MainBuyReqData"] = invDataTable;
            }
            else
            {
                invDataTable = (DataTable)Session["MainBuyReqData"];
            }

            var invPageData = invDataTable.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var invResults = invPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            InvnTotals invGrandSum = new InvnTotals();
            if (Session["MainBuyReqTotals"] == null)
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
                Session["MainBuyReqTotals"] = invGrandSum;
            }
            else
            {
                invGrandSum = (InvnTotals)Session["MainBuyReqTotals"];
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

        [HttpPost]
        public ActionResult DelSelecteds(string carttype)
        {
            HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];

            string vClientCd = Convert.ToString(Session["Clientcd"]);
            string vStatus = carttype;

            if (reqCookie != null)
            {
                List<string> selectedCart = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                int retVal = InventoryModel.RemoveCartByClient(vClientCd, selectedCart, carttype);

                string respUrl = carttype.ToLower() == "cart" ? Url.Action("MyCart", "InventoryCart") : Url.Action("MyBuyRequest", "InventoryCart");

                return Json(new { isError = false, rerUtl = respUrl }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { isError = true }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult UploadCart()
        {
            Session["Cur_UploadCart_ID"] = null;
            return View();
        }

        [HttpPost]
        [ActionName("UploadCart")]
        [ValidateUserAttribute]
        public ActionResult UploadCart_Post()
        {
            string curGUID = Guid.NewGuid().ToString();
            if (Request.Files.Count == 1)
            {
                string fName = string.Empty;

                HttpPostedFileBase file = Request.Files[0];
                fName = file.FileName;

                if (file != null && file.ContentLength > 0)
                {
                    var originalDirectory = new DirectoryInfo(string.Format("{0}ClientData", Server.MapPath(@"\")));

                    string pathString = originalDirectory.ToString();

                    var fileName1 = Path.GetFileName(file.FileName);

                    if (Path.GetExtension(file.FileName).ToLower() == ".xlsx")
                    {
                        bool isExists = System.IO.Directory.Exists(pathString);

                        if (!isExists)
                            System.IO.Directory.CreateDirectory(pathString);

                        var path = string.Format("{0}\\{1}", pathString, curGUID + ".xlsx");
                        file.SaveAs(path);
                    }

                    Session["Cur_UploadCart_ID"] = curGUID;

                    return Json(new { isError = false, msg = "File uploading has been done", respUrl = @Url.Action("ViewExcelCartData", "InventoryCart") }, JsonRequestBehavior.AllowGet);

                    //return RedirectToAction("UploadClientCart", "InventoryCart");
                }
                else
                {
                    return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult ViewExcelCartData()
        {
            string curGUID = Convert.ToString(Session["Cur_UploadCart_ID"]);
            if (curGUID == "") { return RedirectToAction("UploadCart"); }
            else
            {
                DataTable dt = GetDataTableFromExcel(curGUID);
                Session["ExcelData"] = dt;
                List<string> cartRefNos = dt.AsEnumerable().Select(dr => dr.Field<string>("Stoneid")).ToList();
                ViewBag.CartData = cartRefNos;
                return View();
            }
        }

        [HttpPost]
        [ActionName("ViewExcelCartData")]
        [ValidateUserAttribute]
        public ActionResult ViewExcelCartData_Post(string CartType)
        {
            string vCartType = CartType.ToUpper() != "CART" ? "B" : "I";
            string curGUID = Convert.ToString(Session["Cur_UploadCart_ID"]);
            if (curGUID == "") { return Json(new { isError = true, msg = "No Such data file found" }, JsonRequestBehavior.AllowGet); }
            else
            {
                DataTable dt = (DataTable)Session["ExcelData"];
                var cartRefNos = dt.AsEnumerable().Select(dr => dr.Field<string>("STONEID")).ToList();
                string retMsg = ShoppingCart(vCartType, cartRefNos.ToList());

                /*-------------------------------------------------------------remove previously stored excel xlsx file */
                string file = Server.MapPath(string.Format("~/ClientData/{0}.xlsx", curGUID));

                if (System.IO.File.Exists(file))
                {
                    System.IO.File.Delete(file);
                    Session["ExcelData"] = null;
                    Session["Cur_UploadCart_ID"] = null;
                }

                /*-------------------------------------------------------------request type to redirect url */
                if (vCartType == "B")
                    return Json(new { retUrl = Url.Action("MyBuyRequest"), title = "Add to Buy Request", msg = retMsg });
                else
                    return Json(new { retUrl = Url.Action("MyCart"), title = "Add to Cart", msg = retMsg });
            }
        }

        [NonAction]
        public DataTable GetDataTableFromExcel(string hashKey)
        {
            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                using (var stream = System.IO.File.OpenRead(Server.MapPath(string.Format("~/ClientData/{0}.xlsx", hashKey))))
                {
                    pck.Load(stream);
                }
                var ws = pck.Workbook.Worksheets.First();
                DataTable tbl = new DataTable();
                bool hasHeader = true; // adjust it accordingly( i've mentioned that this is a simple approach)
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    tbl.Columns.Add(hasHeader ? firstRowCell.Text.ToUpper() : string.Format("Column {0}", firstRowCell.Start.Column));
                }
                var startRow = hasHeader ? 2 : 1;
                for (var rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    var row = tbl.NewRow();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                    tbl.Rows.Add(row);
                }
                return tbl;
            }
        }

        [NonAction]
        private string ShoppingCart(string cartType, List<string> RefNos)
        {
            string vClientCd = Convert.ToString(Session["Clientcd"]);
            string vStatus = cartType;

            List<string> ClientCart = ClientInventory.GetClientCart(vClientCd, vStatus);

            //HttpCookie reqCookie = Request.Cookies["CK_SELECTEDS"];

            string retRefNo = "";

            if (RefNos != null)
            {
                //List<string> selectedCart = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                var duplicates = RefNos.Intersect(ClientCart).ToList();

                var validCartRefno = RefNos.Except(ClientCart).ToList();

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

                        int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, null, mailContents.Subject, msgBody, null, GetDataBytes(RefNos));
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

        [NonAction]
        private byte[] GetDataBytes(List<string> RefNos)
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

            if (RefNos != null)
                selectedRefno = RefNos.ToArray();
            //selectedRefno = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

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
    }
}