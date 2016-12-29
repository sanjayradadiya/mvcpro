using System;
using System.Data;
using System.IO;
using System.Web;
using System.Linq;
using System.Web.Mvc;
using WebInventory.Areas.Admin.Models;
using WebInventory.Areas.Admin.ViewModels;
using WebInventory.Common;
using WebInventory.Filters;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;

namespace WebInventory.Areas.Admin.Controllers
{
    public class DashboardController : Controller
    {
        //
        // GET: /Admin/AdminDashboard/
        [UserLevel]
        public ActionResult Index()
        {
            return View();
        }

        #region Company Details

        [UserLevel]
        [ValidateUser]
        public ActionResult CompanyDets()
        {
            CompanyDetVM companyDetObj = new CompanyDetVM();

            DataRow dr = CompanyProfile.GetLocations("SURAT");
            companyDetObj.cAddress = Convert.ToString(dr["ADDRESS"]);
            companyDetObj.cBankDetails = Convert.ToString(dr["BANKDETAILS"]);
            companyDetObj.cPhoneDetails = Convert.ToString(dr["PHONEDETAILS"]);
            companyDetObj.cRoutingDetails = Convert.ToString(dr["ROUTINGDETAILS"]);

            return View(companyDetObj);
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("CompanyDets")]
        public ActionResult CompanyDets_Post(string ptype)
        {
            if (!string.IsNullOrEmpty(ptype))
            {

                CompanyDetVM companyDetObj = new CompanyDetVM();

                DataRow dr = CompanyProfile.GetLocations(ptype.ToUpper());

                if (dr == null) { return Json(new { isError = true, msg = "Something went wrong,Please try again" }, JsonRequestBehavior.AllowGet); }

                companyDetObj.cAddress = Convert.ToString(dr["ADDRESS"]);
                companyDetObj.cBankDetails = Convert.ToString(dr["BANKDETAILS"]);
                companyDetObj.cPhoneDetails = Convert.ToString(dr["PHONEDETAILS"]);
                companyDetObj.cRoutingDetails = Convert.ToString(dr["ROUTINGDETAILS"]);

                return Json(new { isError = false, data = companyDetObj }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong,Please try again" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("PostCompanyDets")]
        public ActionResult CompanyDets_Update(CompanyDetVM companyDTO)
        {
            if (ModelState.IsValid)
            {
                int retVal = CompanyProfile.setCompanyDets(companyDTO);

                if (retVal <= 0) { return Json(new { isError = true, msg = "Something went wrong,Please try again" }, JsonRequestBehavior.AllowGet); }

                return Json(new { isError = false, msg = "Modification has been done successfully" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong,Please try again" }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region MediaUploads
        [HttpGet]
        [ValidateUser]
        public ActionResult UploadMedia()
        {
            return View();
        }

        [HttpPost]
        [ValidateUser]
        [ActionName("UploadMedia")]
        public ActionResult UploadMedia_Post()
        {
            if (Request.Files.Count > 0)
            {
                string fName = string.Empty;
                string fLocation = string.Empty;
                foreach (string fileName in Request.Files)
                {
                    HttpPostedFileBase file = Request.Files[fileName];
                    fName = file.FileName;

                    switch (fileName)
                    {
                        case "file-dg[]": fLocation = "diams\\digital"; break;
                        case "file-arr[]": fLocation = "diams\\arrow"; break;
                        case "file-ass[]": fLocation = "diams\\asset"; break;
                        case "file-hr[]": fLocation = "diams\\heart"; break;
                        case "file-idl[]": fLocation = "diams\\ideal"; break;
                        case "file-cr[]": fLocation = "certs"; break;
                        case "file-vd[]": fLocation = "video"; break;
                    }

                    if (file != null && file.ContentLength > 0)
                    {
                        var originalDirectory = new DirectoryInfo(string.Format("{0}Images\\StockImg\\{1}", Server.MapPath(@"\"), fLocation));

                        string pathString = originalDirectory.ToString();

                        var fileName1 = Path.GetFileName(file.FileName);

                        bool isExists = System.IO.Directory.Exists(pathString);

                        if (!isExists)
                            System.IO.Directory.CreateDirectory(pathString);

                        bool isFileExt = false;

                        if (fLocation == "video")
                            isFileExt = Path.GetExtension(pathString).ToLower() != ".mp4";
                        else
                            isFileExt = Path.GetExtension(pathString).ToLower() != ".jpg";

                        if (isFileExt == true)
                        {
                            var path = string.Format("{0}\\{1}", pathString, file.FileName);
                            file.SaveAs(path);
                        }
                        else
                        {
                            return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
                        }
                    }
                }
            }
            return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Email File Uploader

        [HttpGet]
        [ValidateUser]
        public ActionResult UploadEmailFile()
        {
            return View();
        }

        [HttpPost]
        [ValidateUser]
        [ActionName("UploadEmailFile")]
        public ActionResult UploadEmailFile_Post()
        {
            if (Request.Files.Count == 1)
            {
                string fName = string.Empty;

                HttpPostedFileBase file = Request.Files[0];
                fName = file.FileName;

                if (file != null && file.ContentLength > 0)
                {
                    var originalDirectory = new DirectoryInfo(string.Format("{0}EmailSubScribeFile", Server.MapPath(@"\")));

                    string pathString = originalDirectory.ToString();

                    var fileName1 = Path.GetFileName(file.FileName);

                    if (Path.GetExtension(file.FileName).ToLower() == ".xlsx")
                    {
                        bool isExists = System.IO.Directory.Exists(pathString);

                        if (!isExists)
                            System.IO.Directory.CreateDirectory(pathString);

                        //var path = string.Format("{0}\\{1}", pathString, file.FileName);
                        var path = string.Format("{0}\\{1}", pathString, "StockUpdates.xlsx");
                        file.SaveAs(path);
                    }
                }
            }
            return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Email Subscribers

        [HttpGet]
        [ValidateUser]
        public ActionResult EmailSubSrcbDets()
        {
            Session["EmailSubSrcbData"] = null;
            return View();
        }

        [HttpPost]
        [ValidateUser]
        [ActionName("EmailSubSrcbDets")]
        public ActionResult EmailSubSrcbDets_Post(JQueryDataTableParamModel param)
        {
            string vEmailId = Convert.ToString(Request["EmailId"]);
            string vStatus = Convert.ToString(Request["ssStatus"]);
            param = param ?? new JQueryDataTableParamModel();

            AdminClientMaster clientMaster = new AdminClientMaster();
            DataTable gmDataTable = null;
            DataTable filteredTable = null;

            if (vStatus != null) Session["EmailSubSrcbData"] = null;

            if (Session["EmailSubSrcbData"] == null)
            {
                gmDataTable = clientMaster.GetEmailSubScrbDets(vEmailId, vStatus);
                filteredTable = gmDataTable;
                Session["EmailSubSrcbData"] = gmDataTable;
            }
            else
            {
                gmDataTable = (DataTable)Session["EmailSubSrcbData"];
                filteredTable = gmDataTable;
            }

            var cmPageData = filteredTable.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var cmResults = cmPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = filteredTable.Rows.Count,
                iTotalDisplayRecords = filteredTable.Rows.Count,
                aaData = cmResults,
            }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Website Settings

        [HttpGet]
        public ActionResult Settings()
        {
            return View();
        }

        [HttpPost]
        [ActionName("Settings")]
        public ActionResult Settings_Post(JQueryDataTableParamModel param)
        {
            ProcessMaster processMaster = new ProcessMaster();
            DataTable settingData = null;

            if (ViewData["Settings"] == null)
            {
                settingData = processMaster.GetSettingsDet();
                ViewData["Settings"] = settingData;
            }
            else
            {
                settingData = (DataTable)ViewData["Settings"];
            }

            var pdPageData = settingData.Select();
            var pdResults = pdPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = settingData.Rows.Count,
                iTotalDisplayRecords = settingData.Rows.Count,
                aaData = pdResults,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult HandleSets(string name, string value)
        {
            if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(value))
            {
                int retval = ProcessMaster.UpdateSettingsDet(name, value);
                if (retval > 0)
                {
                    return Json(new { isError = false, msg = "Successfully updated." });
                }
            }
            return Json(new { isError = true, msg = "Something went wrong" });
        }

        #endregion

        #region Upload Manual Stock Upload  (WebSync_Utility)

        [HttpGet]
        public ActionResult UploadStock()
        {
            return View();
        }

        [NonAction]
        private string UploadedFilePath()
        {
            var originalDirectory = new DirectoryInfo(string.Format("{0}ClientData", Server.MapPath(@"\")));
            return originalDirectory.ToString();
        }

        [HttpPost]
        [ActionName("UploadStock")]
        public ActionResult UploadStock_Post()
        {
            if (Request.Files.Count == 1)
            {
                string fName = string.Empty;
                //Session["ExcelSyncData"] = null;
                //Session["ExcelSyncColumns"] = null;

                HttpPostedFileBase file = Request.Files[0];
                fName = file.FileName;

                string pathString = UploadedFilePath();
                string path = string.Format("{0}\\{1}", pathString, "UploadedStock.xlsx");

                if (file != null && file.ContentLength > 0)
                {
                    var fileName1 = Path.GetFileName(file.FileName);

                    if (Path.GetExtension(file.FileName).ToLower() == ".xlsx")
                    {
                        bool isExists = System.IO.Directory.Exists(pathString);

                        if (!isExists)
                            System.IO.Directory.CreateDirectory(pathString);

                        //var path = string.Format("{0}\\{1}", pathString, file.FileName);

                        file.SaveAs(path);
                    }
                }
                return Json(new { isError = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { isError = true, msg = "Something went wrong, File uploading has failed, Please try again" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult ColumnMap()
        {
            string pathString = UploadedFilePath();
            string path = string.Format("{0}\\{1}", pathString, "UploadedStock.xlsx");

            DataTable excelDataTable = XlsxToDatatable.GenerateDataTable(path);
            Session["ExcelSyncData"] = excelDataTable;


            var excelCols = (from column in excelDataTable.Columns.Cast<DataColumn>()
                             select column.ColumnName).ToList();

            Session["ExcelSyncColumns"] = excelCols;

            List<SelectListItem> vExcelColumns = (from item in excelCols
                                                  select new SelectListItem { Text = item, Value = item }).ToList();

            var vExcelColumnMapper = from fieldNm in XlsxToDatatable.GetExcelColumnMapper().AsEnumerable()
                                     select new ExcelFormatter
                                     {
                                         ColumnName = fieldNm.Field<string>("COLUMN_NAME"),
                                         ShowColumnName = fieldNm.Field<string>("SHOWCOLUMN_NAME"),
                                         IsRequired = fieldNm.Field<bool>("ISREQUIRED"),
                                         MatchCols = fieldNm.Field<string>("COLUMN_MAPPING").Split(new char[] { ',' }),
                                         Ord = fieldNm.Field<decimal>("ORD")
                                     };

            if (vExcelColumns.Count > 0)
            {
                ViewBag.ExcelColumns = vExcelColumns;
                ViewBag.ExcelColumnMapper = vExcelColumnMapper;
            }

            return PartialView("ColumnMap");
        }

        [HttpPost]
        public ActionResult ValidateFile(List<string> mappedCols)
        {
            List<string> excelCols = new List<string>();
            DataTable excelDataTable = (DataTable)Session["ExcelSyncData"];
            excelCols = (List<string>)Session["ExcelSyncColumns"];

            var srcColumns = (from fieldNm in XlsxToDatatable.GetExcelColumnMapper().AsEnumerable()
                              select fieldNm.Field<string>("COLUMN_NAME")).ToList();


            Dictionary<string, string> mapCols = new Dictionary<string, string>();

            for (int i = 0; i < srcColumns.Count(); i++)
            {
                if (mappedCols[i] != null && mappedCols[i] != "")
                    mapCols.Add(srcColumns[i], mappedCols[i]);
            }

            if (mapCols.Count > 0)
            {
                if (mapCols.ContainsKey("LENGTH"))
                {
                    excelDataTable.Columns.Add("MEASUREMENT", typeof(string));

                    foreach (DataRow dr in excelDataTable.Rows)
                    {
                        dr["MEASUREMENT"] = Convert.ToString(dr["LENGTH"]) + "-" + Convert.ToString(dr["WIDTH"]) + "-" + Convert.ToString(dr["HEIGHT"]);
                    }

                    mapCols.Add("MEASUREMENT", "MEASUREMENT");
                }
                ComFunc.excNonQuery("TRUNCATE TABLE EXCEL_GRADDET");
                using (SqlConnection sqlCon = new SqlConnection(ComFunc.sqlConStr))
                {
                    if (sqlCon.State == ConnectionState.Closed) sqlCon.Open();

                    using (SqlBulkCopy bulkCopier = new SqlBulkCopy(sqlCon))
                    {
                        bulkCopier.BulkCopyTimeout = 6000000;
                        bulkCopier.DestinationTableName = "EXCEL_GRADDET";

                        foreach (var item in mapCols)
                        {
                            bulkCopier.ColumnMappings.Add(item.Value, item.Key);
                        }

                        bulkCopier.WriteToServer(excelDataTable);
                    }
                }

                DataTable errorList = ComFunc.excDataTable("SELECT RNO, ERROR_DESC FROM FUNC_EXCEL_STOCK_ERRORS()", null, CommandType.Text);

                if (errorList.Rows.Count > 0)
                {
                    Dictionary<string, string> rep = (from dr in errorList.AsEnumerable()
                                                      select new
                                                      {
                                                          RowNum = Convert.ToString(dr.Field<decimal>("RNO")),
                                                          Description = dr.Field<string>("ERROR_DESC").Trim(new char[] { ';' }).Replace(";", "  ||  ")
                                                      }).AsEnumerable().ToDictionary(k => k.RowNum, v => v.Description);

                    Session["ErrorLog"] = rep;

                    return Json(new { isError = true, retUrl = @Url.Action("ViewErrorLogs"), res = "File got some invalid values" });
                }
                return Json(new { isError = false, retUrl = "", res = "No such errors found" });
            }

            return Json(new { isError = true, retUrl = "", res = "No such errors found" });
        }


        [HttpGet]
        public ActionResult ViewErrorLogs()
        {
            if (Session["ErrorLog"] != null)
            {
                ViewBag.ErrorLogs = (Dictionary<string, string>)Session["ErrorLog"];
                ViewBag.IsError = false;
            }
            return View();
        }
        #endregion

    }
}
