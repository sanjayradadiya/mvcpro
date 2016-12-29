using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebInventory.Common;
using WebInventory.ViewModels;
using WebInventory.Areas.Admin.ViewModels;
using WebInventory.Areas.Admin.Models;
using WebInventory.Filters;
using WebInventory.Models;
using System.Globalization;

namespace WebInventory.Areas.Admin.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Admin/Account/
        #region AdminLogin

        [AllowAnonymous]
        [AcceptVerbs(HttpVerbs.Get), ActionName("Index")]
        public ActionResult Login()
        {
            LoginVM loginDTO = new LoginVM();
            Session.Abandon();
            if (Request.Cookies["webcrd"] != null)
            {
                GetAuthCookie(Request.Cookies["webcrd"], loginDTO);
            }

            return View(loginDTO);
        }

        [AcceptVerbs(HttpVerbs.Post), ActionName("Index")]
        public ActionResult Login(LoginVM loginDto)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                DataTable clientDt = cm.CheckUser(loginDto);

                if (clientDt != null & clientDt.Rows.Count > 0)
                {
                    var clientData = (from DataRow c in clientDt.AsEnumerable()
                                      select new
                                      {
                                          gPassword = c.Field<string>("password"),
                                          gClientCd = c.Field<int>("clientcd"),
                                          gClientEmailId = c.Field<string>("emailid1"),
                                          gClientName = c.Field<string>("clientname"),
                                          gFirstName = c.Field<string>("firstname"),
                                          gClientStatus = c.Field<string>("status"),
                                          gClientIsSeller = c.Field<string>("isseller"),
                                          gClientLoginType = c.Field<int>("utypeid"),
                                          gClientAddress = c.Field<string>("clientfulladdress"),
                                          gClientHandle_Location = c.Field<int?>("handle_location")
                                      }).SingleOrDefault();

                    if (loginDto.RememberMe) { CreateAuthCookie(loginDto.Username, loginDto.Password); }
                    else { Response.Cookies["webcrd"].Expires = DateTime.Now.AddDays(-1); }

                    Session["LOGID"] = cm.ClientLoginHistory(clientData.gClientCd, Selector.GetIPAddress(), Session.SessionID, "I", 0);

                    Session["ClientFullAddress"] = clientData.gClientAddress;
                    Session["Clientcd"] = clientData.gClientCd;
                    Session["clientname"] = clientData.gClientName;
                    Session["FirstName"] = clientData.gFirstName;
                    Session["Emailid"] = clientData.gClientEmailId;
                    Session["LoginType"] = clientData.gClientLoginType;
                    Session["IsSeller"] = clientData.gClientIsSeller;
                    Session["curRequestIp"] = Selector.GetIPAddress();
                    Session["ClientHandle_Location"] = clientData.gClientHandle_Location;
                    Session["global-infoMail"] = WebSiteSettings.Global_InfoMail;
                    Session["global-website"] = WebSiteSettings.Global_Website;

                    if (clientData.gClientLoginType != 0)
                        return Json(new { url = @Url.Action("Index", "Dashboard"), iserror = false });
                    else
                        return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "User details not found, Please try again.." });
                }
                else
                {
                    return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "User details not found, Please try again.." });
                }
            }
            return View(loginDto);
        }

        [NonAction]
        private void CreateAuthCookie(string unm, string pwd)
        {
            HttpCookie webcrd = new HttpCookie("webcrd");
            webcrd.Value = DataEncrDecription.EncryptQueryString(unm) + "|" + DataEncrDecription.EncryptQueryString(pwd);
            Response.Cookies.Add(webcrd);
        }

        [NonAction]
        private void GetAuthCookie(HttpCookie webcrd, LoginVM loginObj)
        {
            HttpCookie authCookie = webcrd;
            string[] cookieVal = authCookie.Value.Split(new Char[] { '|' });
            loginObj.Username = DataEncrDecription.DecryptQueryString(cookieVal[0]);
            loginObj.Password = DataEncrDecription.DecryptQueryString(cookieVal[1]);
            loginObj.RememberMe = true;
            Response.Cookies.Add(webcrd);
        }

        #endregion

        #region "LogOff"

        public ActionResult LogOff()
        {
            Session.Abandon();
            Request.Cookies["ASP.NET_SessionId"].Expires=DateTime.Now.AddMonths(-1);
            return RedirectToAction("Index", "Account", new { area = "Admin" });
        }

        #endregion

        #region ClientMaster

        [HttpGet]
        [UserLevel]
        [ValidateUser]
        public ActionResult ClientDetails()
        {
            Session["ClientMas"] = null;
            Session["ClientMasEXP"] = null;
            Session["cLoginData"] = null;
            ViewBag.UserLevels = AdminClientMaster.GetUserLevels();
            ViewBag.UserStatus = ClientEditProfileVM.GetClientStatus();
            return View();
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("ClientDetails")]
        public ActionResult ClientDetails_Post(JQueryDataTableParamModel param, string searchParams)
        {
            int? idLevel = null;
            if (Request["uLevel"] != null && Request["uLevel"] != "")
                idLevel = Convert.ToInt32(Request["uLevel"]);
            var idStatus = Convert.ToString(Request["uStatus"]);
            param = param ?? new JQueryDataTableParamModel();

            AdminClientMaster clientMaster = new AdminClientMaster();
            DataTable cmDataTable = null;
            DataTable filteredTable = null;

            //string searchParams = Convert.ToString(Session["cm_searchQuery"]);

            //if (idLevel != null || !string.IsNullOrEmpty(idStatus))
            //{
            //    Session["ClientMas"] = null;
            //}


            if (Session["ClientMas"] == null)
            {
                cmDataTable = clientMaster.GetClientDetails(null, null);
                filteredTable = cmDataTable;
                Session["ClientMas"] = cmDataTable;
            }
            else
            {
                cmDataTable = (DataTable)Session["ClientMas"];
                filteredTable = cmDataTable;

                if (idLevel != null)
                {
                    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<int>("UTYPEID") == idLevel);
                    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                }
                if (!string.IsNullOrEmpty(idStatus))
                {
                    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<string>("STATUSDESC") == idStatus);
                    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                }

                if (Request["uName"] != "" && Request["uName"] != null)
                {
                    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<string>("LOGINNAME") == Request["uName"]);
                    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                }

            }

            Session["ClientMasEXP"] = filteredTable;

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

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("LoginNames")]
        public JsonResult GetClientLogonNames(string preFix)
        {
            DataTable cData = null;
            if (Session["cLoginData"] == null)
            {
                cData = AdminClientMaster.GetClientLoginNames(null);
                Session["cLoginData"] = cData;
            }
            else
                cData = (DataTable)Session["cLoginData"];

            var filteredData = cData.AsEnumerable().Select(dr => dr.Field<string>("NM")).Where(x => x.Contains(preFix)).Select(x => new { id = x.ToString(), Name = x.ToString() }).Take(10).ToList();

            return Json(filteredData, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Edit Client Profile

        [HttpGet]
        [ValidateUser]
        public ActionResult EditClient()
        {
            ClientEditProfileVM profile = new ClientEditProfileVM();

            if (Convert.ToString(Session["cid"]) == "" && Convert.ToString(Session["cname"]) == "") return View();

            profile = AdminClientMaster.ClientProfile(Convert.ToString(Session["cid"]), Convert.ToString(Session["cname"]));

            profile.statusFlag = profile.status == "Y" ? true : false;

            profile.ListHandlingLocation = ClientEditProfileVM.GetHandlingLocation();
            profile.ListSalesMgr = ClientEditProfileVM.GetSalesManager();
            profile.ListEmailType = ClientEditProfileVM.GetEmailSchedule();
            profile.ListTitles = ClientEditProfileVM.GetTitles();
            profile.ListCountries = ClientEditProfileVM.GetCountries();
            profile.ListBusinessTypes = ClientEditProfileVM.GetBusineTypes();
            profile.ListUserLevels = ClientEditProfileVM.GetUserLevels();

            return View(profile);
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("EditClient")]
        public ActionResult EditClient_post(string rowid, string clname)
        {
            ClientEditProfileVM profile = new ClientEditProfileVM();

            profile = AdminClientMaster.ClientProfile(rowid, clname);
            if (profile != null)
            {
                Session["cid"] = rowid;
                Session["cname"] = clname;
                return Json(new { isError = false }, JsonRequestBehavior.AllowGet);
            }

            return Json(new { isError = true }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        public ActionResult UpdateClientProfile(ClientEditProfileVM profileObj)
        {
            if (ModelState.IsValid)
            {
                AdminClientMaster cm = new AdminClientMaster();
                profileObj.UpdatedBy = Convert.ToInt32(Session["Clientcd"]);
                profileObj.status = profileObj.status.ToLower() == "true" ? "Y" : "P";
                int result = cm.UpdateClient(profileObj);

                switch (result)
                {
                    case 0: return Json(new { url = @Url.Action("Index", "Account"), iserror = false, msg = "Updates has been done successfully.." });
                    case 1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Member details have been found, Please contact to Administrator.." });
                    case -1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Unfortunately Member details not registered.." });
                    default: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Please contact to Administrator.." });
                }
            }

            profileObj.ListHandlingLocation = ClientEditProfileVM.GetHandlingLocation();
            profileObj.ListSalesMgr = ClientEditProfileVM.GetSalesManager();
            profileObj.ListTitles = ClientEditProfileVM.GetTitles();
            profileObj.ListBusinessTypes = ClientEditProfileVM.GetBusineTypes();
            profileObj.ListCountries = ClientEditProfileVM.GetCountries();
            profileObj.ListUserLevels = ClientEditProfileVM.GetUserLevels();
            return View(profileObj);
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        public string avoidClient(string cid, string clname)
        {
            AdminClientMaster cm = new AdminClientMaster();

            int result = cm.RemoveClient(cid, clname, Convert.ToInt32(Session["Clientcd"]));

            if (result == 0) { return "Unfortunately Member details not modified.."; }
            else { return "Updates has been done successfully.."; }
        }
        #endregion

        #region Export
        public ActionResult ClientExportExcel()
        {
            if (Session["ClientDetsExcel"] != null)
            {
                Byte[] StreamBytes = Session["ClientDetsExcel"] as Byte[];
                Session["ClientDetsExcel"] = null;
                return File(StreamBytes, System.Net.Mime.MediaTypeNames.Application.Octet, string.Format("ClientDetails.xlsx", WebSiteSettings.Global_Website));
            }
            return new EmptyResult();
        }

        [HttpPost]
        [ValidateUser]
        [ActionName("ClientExportExcel")]
        public ActionResult ClientExcelExport()
        {
            HttpCookie reqCookie = Request.Cookies["clid"];
            Session["ClientDetsExcel"] = GetDataBytes(reqCookie);
            return Json(new { status = 200 }, JsonRequestBehavior.AllowGet);
        }

        [NonAction]
        private byte[] GetDataBytes(HttpCookie reqCookie)
        {
            AdminClientMaster clientMaster = new AdminClientMaster();
            DataTable cmDataTable = null;
            if (Session["ClientMasEXP"] == null)
            {
                cmDataTable = clientMaster.GetClientDetails(null, null);
                Session["ClientMasEXP"] = cmDataTable;
            }
            else
            {
                cmDataTable = (DataTable)Session["ClientMasEXP"];
            }

            int[] selectedRefno = null;

            if (reqCookie != null)
                selectedRefno = HttpUtility.UrlDecode(reqCookie.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x)).ToArray();

            string[] selectedColumns = new[] { "LOGINNAME", "CLIENTNAME", "SALESMAN", "LOCATION", "LASTLOGGEDON", "COMPANYNM", "DESIGNATION", "CONTACTNO", "WEBSITE", "CITY", "COUNTRY", "STATUSDESC", "MAILTYPE", "SC_CNT", "BR_CNT", "WL_CNT", "TRACKED_IP" };

            DataTable selectedData;
            if (selectedRefno != null)
            {
                DataTable curTable = cmDataTable.AsEnumerable()
                                     .Where(c => selectedRefno.Contains(c.Field<int>("CLIENTCD"))).CopyToDataTable();

                selectedData = new DataView(curTable).ToTable(false, selectedColumns);
            }
            else
            {
                selectedData = new DataView(cmDataTable).ToTable(false, selectedColumns);
            }

            return ClientExcelExporter.GenerateReport(selectedData, "ClientDetails");
        }

        #endregion

        #region AppointmentMaster

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult AppointmentDets()
        {
            Session["ApptMas"] = null;
            return View();
        }

        [HttpPost]
        [ValidateUserAttribute]
        [ActionName("AppointmentDets")]
        public ActionResult BookAppointment_Post(JQueryDataTableParamModel param)
        {
            string vApptStatus = Convert.ToString(Request["apptStatus"]);
            string stDate = string.Empty; string endDate = string.Empty;
            if (Request["aFdate"] != "" && Request["aTdate"] != "")
            {
                stDate = Convert.ToString(Request["aFdate"]);
                endDate = Convert.ToString(Request["aTdate"]);
            }
            param = param ?? new JQueryDataTableParamModel();

            AdminClientMaster clientMaster = new AdminClientMaster();
            DataTable apptDataTable = null;
            DataTable filteredTable = null;

            if (Session["ApptMas"] == null)
            {
                apptDataTable = clientMaster.GetAppointDetails(stDate, endDate, vApptStatus);
                filteredTable = apptDataTable;
                Session["ApptMas"] = apptDataTable;
            }
            else
            {
                apptDataTable = (DataTable)Session["ApptMas"];
                filteredTable = apptDataTable;

                if (!string.IsNullOrEmpty(vApptStatus))
                {
                    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<string>("STATUS") == vApptStatus);
                    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                }

                if (!string.IsNullOrEmpty(stDate) && !string.IsNullOrEmpty(endDate))
                {
                    DateTime vStDate = DateTime.ParseExact(stDate, "dd-MM-yyyy", CultureInfo.InvariantCulture);
                    DateTime vendDate = DateTime.ParseExact(endDate, "dd-MM-yyyy", CultureInfo.InvariantCulture);

                    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<DateTime>("APPOINTMENTON") >= vStDate && dr.Field<DateTime>("APPOINTMENTON") <= vendDate);
                    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                }
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

        [HttpPost]
        [ValidateUser]
        public ActionResult HandleAppt(string id, string flag)
        {
            if (flag != "")
            {
                int rtval = 0;
                AdminClientMaster adminClientMaster = new AdminClientMaster();
                string vFlag = string.Empty;
                switch (flag.ToUpper())
                {
                    case "FIXED": vFlag = "F"; break;
                    case "PENDING": vFlag = "P"; break;
                    case "REJECTED": vFlag = "R"; break;
                    default: vFlag = "R"; break;
                }
                rtval = adminClientMaster.SetAppointmentStatus(Convert.ToInt32(id), vFlag, Convert.ToString(Session["ClientCd"]));
                if (rtval == 1)
                {
                    Session["ApptMas"] = null;

                    //DateTime date = DateTime.ParseExact(DateTime.Now.ToString(), "dd-MM-yyyy h:mm:ss tt", CultureInfo.InvariantCulture);
                    
                    DataRow dr = adminClientMaster.GetAppointDetailsById(id);
                    if (dr != null)
                    {
                        MailContentsVM mailContents = new MailContentsVM();
                        mailContents.To = Convert.ToString(dr["EMAILID"]);
                        mailContents.Bcc = ClientInventory.GetSalesManEmailId();

                        string msgBody = string.Empty;
                        if (vFlag == "F")   //Approved
                        {
                            mailContents.Subject = "Confirmation of Appointment @-" + WebInventory.ViewModels.WebSiteSettings.Global_Website;

                            mailContents.Message = "Please note that your appoinment has been confirmed.<br/> Kindly note this following appointment Details:";

                            msgBody = ComFunc.ReadHtml("AdminAppointments.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                            .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                            .Replace("`req-date`", Convert.ToString(dr["APPOINTMENTON"])).Replace("`req-ftime`", Convert.ToString(dr["FTIME"])).Replace("`req-ttime`", Convert.ToString(dr["TTIME"]))
                            .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));
                        }
                        else if (vFlag == "R")   //Rejection
                        {
                            mailContents.Subject = "Appointment @-" + WebInventory.ViewModels.WebSiteSettings.Global_Website + "has been rejected";

                            mailContents.Message = "We regret that your appointment request has been rejected due to inavailability of respective executives.";

                            msgBody = ComFunc.ReadHtml("AdminAppointments.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                            .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                            .Replace("`req-date`", Convert.ToString(dr["APPOINTMENTON"])).Replace("`req-ftime`", Convert.ToString(dr["FTIME"])).Replace("`req-ttime`", Convert.ToString(dr["TTIME"]))
                            .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));
                        }

                        int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, mailContents.Bcc, mailContents.Subject, msgBody, null, null);
                    }
                    else
                    {
                        return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("AppointmentDets", "Account") }, JsonRequestBehavior.AllowGet);
                    }
                }
                return Json(new { isError = false, msg = "Appointment status setted", url = @Url.Action("AppointmentDets", "Account") }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("AppointmentDets", "Account") }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region Guest Master
        [UserLevel]
        [ValidateUser]
        public ActionResult GuestDets()
        {
            Session["GuestMas"] = null;
            return View();
        }

        [HttpPost]
        [UserLevel]
        [ValidateUser]
        [ActionName("GuestDets")]
        public ActionResult GuestDets_Post(JQueryDataTableParamModel param, string searchParams)
        {
            //var idStatus = Convert.ToString(Request["uStatus"]);
            param = param ?? new JQueryDataTableParamModel();

            AdminClientMaster clientMaster = new AdminClientMaster();
            DataTable gmDataTable = null;
            DataTable filteredTable = null;

            if (Session["GuestMas"] == null)
            {
                gmDataTable = clientMaster.GetGuestDetails(null);
                filteredTable = gmDataTable;
                Session["GuestMas"] = gmDataTable;
            }
            else
            {
                gmDataTable = (DataTable)Session["GuestMas"];
                filteredTable = gmDataTable;

                //if (!string.IsNullOrEmpty(idStatus))
                //{
                //    var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<string>("STATUSDESC") == idStatus);
                //    filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();
                //}

                //var rows = filteredTable.AsEnumerable().Where(dr => dr.Field<string>("LOGINNAME") == Request["uName"]);
                //filteredTable = rows.Any() ? rows.CopyToDataTable() : filteredTable.Clone();

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

        [HttpPost]
        [ValidateUser]
        public ActionResult HandleGuest(string pEmailId, string pCompanyNm, string pStatus)
        {
            if (pEmailId != "" && pCompanyNm != "" && pStatus != "")
            {
                int rtval = 0;
                AdminClientMaster adminClientMaster = new AdminClientMaster();

                rtval = adminClientMaster.RemoveGuest(pEmailId, pCompanyNm, pStatus);

                return Json(new { isError = false, msg = "Guest has been deleted", url = @Url.Action("GuestDets", "Account") }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("GuestDets", "Account") }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion
    }
}
