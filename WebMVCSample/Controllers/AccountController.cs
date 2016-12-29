using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebInventory.ViewModels;
using WebInventory.Common;
using System.Data;
using WebInventory.Filters;
using System.Globalization;

namespace WebInventory.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/

        /*------------------------------------------------------------Login*/

        #region UserLogin

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
            /*--------to check if the Login call from Main website*/
            string leftPart = Request.UrlReferrer.OriginalString.ToLower();
            if (leftPart.Contains("/home")) { Session["FROM_HOME"] = "YES"; } else { Session["FROM_HOME"] = null; }

            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                DataTable clientDt = cm.CheckUser(loginDto);

                if (clientDt != null & clientDt.Rows.Count > 0)
                {
                    if (Convert.ToString(clientDt.Rows[0]["status"]) == "P")
                        return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Currently This User Not Approved by Administrator, Please try again.." });

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

                    string current_tracedIp = Selector.GetIPAddress();

                    Session["LOGID"] = cm.ClientLoginHistory(clientData.gClientCd, current_tracedIp, Session.SessionID, "I", 0);

                    TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;

                    Session["ClientFullAddress"] = clientData.gClientAddress;
                    Session["Clientcd"] = clientData.gClientCd;
                    Session["clientname"] = clientData.gClientName;
                    Session["FirstName"] = textInfo.ToTitleCase(clientData.gFirstName);
                    Session["Emailid"] = clientData.gClientEmailId;
                    Session["LoginType"] = clientData.gClientLoginType;
                    Session["IsSeller"] = clientData.gClientIsSeller;
                    Session["curRequestIp"] = current_tracedIp;
                    Session["ClientHandle_Location"] = clientData.gClientHandle_Location;
                    Session["global-infoMail"] = WebSiteSettings.Global_InfoMail;
                    Session["global-website"] = WebSiteSettings.Global_Website;

                    //return RedirectToAction("Index", "InventorySearch");
                    return Json(new { url = @Url.Action("Index", "InventorySearch"), iserror = false });
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

        /*------------------------------------------------------------LogOff*/

        #region "LogOff"

        public ActionResult LogOff()
        {
            //string isFrom = Convert.ToString(Session["FROM_HOME"]);
            Session.Abandon();
            Request.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-1);
            if (HttpContext.Request.Url.Host.Contains(WebSiteSettings.Global_Website))
                return Redirect("http://" + WebSiteSettings.Global_Website);
            else
                return RedirectToAction("Index");
        }

        #endregion

        /*--------------------------------------Registration*/

        #region UserSignUP

        [HttpGet]
        [AllowAnonymous]
        public ActionResult SignUp()
        {
            RegistrationVM register = new RegistrationVM();
            //{
            //    birthdate = DateTime.Today
            //};

            register.ListTitles = RegistrationVM.GetTitles();
            register.ListCountries = RegistrationVM.GetCountries();
            register.ListBusinessTypes = RegistrationVM.GetBusineTypes();

            return View(register);
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult SignUp(RegistrationVM registerObj)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                int result = cm.InsertClient(registerObj);

                if (result == 0)
                {
                    MailContentsVM mailContents = new MailContentsVM();
                    mailContents.To = registerObj.LoginName;
                    mailContents.Subject = "Welcome to " + WebSiteSettings.Global_Website;

                    string msgBody = ComFunc.ReadHtml("SignUp.html", null, null)
                       .Replace("`IP-Address`", Selector.GetIPAddress()).Replace("`global-website`", WebSiteSettings.Global_Website)
                       .Replace("`Url`", Request.Url.ToString().RootUrl()).Replace("`signup-user`", registerObj.FirstName);

                    int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, mailContents.Bcc, mailContents.Subject, msgBody, null, null);
                }

                switch (result)
                {
                    case 0: return Json(new { url = @Url.Action("Index", "Account"), iserror = false, msg = "Registration has been done successfully.." });
                    case 1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Member details have been found, Please contact to Administrator.." });
                    case -1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Unfortunately Member details not registered.." });
                    default: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Please contact to Administrator.." });
                }

            }

            registerObj.ListTitles = RegistrationVM.GetTitles();
            registerObj.ListBusinessTypes = RegistrationVM.GetBusineTypes();
            registerObj.ListCountries = RegistrationVM.GetCountries();
            return View(registerObj);
        }

        [HttpPost]
        [Authorize]
        public JsonResult checkUser(string LoginName)
        {
            var isValidUser = ClientMaster.CheckEmail(LoginName);
            return Json(isValidUser == null);
        }
        #endregion

        /*--------------------------------------Forgot Password*/

        #region ForgotPassword

        [AllowAnonymous]
        [AcceptVerbs(HttpVerbs.Get), ActionName("ForgotPassword")]
        public ActionResult ForgotPassword()
        {
            ForgotPasswordVM forgotPasswordDTO = new ForgotPasswordVM();
            return View(forgotPasswordDTO);
        }

        //[ValidateAntiForgeryToken]
        [AcceptVerbs(HttpVerbs.Post), ActionName("ForgotPassword")]
        public ActionResult ForgotPassword(ForgotPasswordVM forgotPasswordDto)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                string curPassword = cm.ForgotPassword(forgotPasswordDto);

                //if (string.IsNullOrEmpty(curPassword))
                //{
                //    TempData["Message"] = "This email id is not registered with us!";
                //    return View(forgotPasswordDto);
                //}

                if (string.IsNullOrEmpty(curPassword))
                {
                    return Json(new { msg = "This email id is not registered with us!", iserror = true });
                }

                string decryPassword = DataEncrDecription.EncryptQueryString(curPassword);

                string reqRootUrl = "<a href='" + Request.Url.ToString().RootUrl() + "/Account/ResetPassword" + "?tg=" + decryPassword + "'> Reset Password </a>";

                string msgBody = ComFunc.ReadHtml("ForgotPassword.html", forgotPasswordDto.RegisteredEmail.ToLower(), "").Replace("`Url`", reqRootUrl).Replace("`IP-Address`", Selector.GetIPAddress());

                SendMail.sendMailWithAuthentication("info@mothergems.in", forgotPasswordDto.RegisteredEmail, "", "", "Forgot password", msgBody, "");

                //return RedirectToAction("Index");
                return Json(new { msg = "As per your request to Forgot Password , the details has been mailed to you.. ", iserror = false });
            }
            else
            {
                return Json(new { msg = "This email id is not registered with us!", iserror = true });
            }
        }

        #endregion

        /*--------------------------------------Reset Password*/

        #region ResetPassword

        [HttpGet]
        [AllowAnonymous]
        public ActionResult ResetPassword()
        {
            ResetPasswordVM resetPasswordDTO = new ResetPasswordVM();
            string mailedPwd = string.Empty;
            Session["FromMail"] = null;
            if (Request.QueryString["tg"] != null)
            {
                ViewBag.BackUrl = @Url.Content("/Account");
                ViewBag.SharedLayout = "~/Views/Shared/_MainLayout.cshtml";
                Session["FromMail"] = Request.QueryString["tg"];
                resetPasswordDTO.OldPassword = Convert.ToString(Request.QueryString["tg"]);
            }
            else
            {
                ViewBag.BackUrl = @Url.Content("/Account/EditProfile");
                ViewBag.SharedLayout = "~/Views/Shared/_Layout.cshtml";
            }
            return View(resetPasswordDTO);
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordVM resetPasswordDto)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();

                //if (resetPasswordDto.OldPassword != null)
                if (Session["FromMail"] != null)
                {
                    //resetPasswordDto.OldPassword = DataEncrDecription.DecryptQueryString(Convert.ToString(Request.QueryString["tg"]));
                    resetPasswordDto.OldPassword = DataEncrDecription.DecryptQueryString(resetPasswordDto.OldPassword);
                }
                int retVal = cm.ResetPassword(resetPasswordDto);

                string _msg = string.Empty;
                switch (retVal)
                {
                    case 0: _msg = "Password has been modified successfully.."; TempData["AlertType"] = "0"; break;
                    case 1: _msg = "Member details not found, Please contact to Administrator.."; break;
                    default: _msg = "Please contact to Administrator.."; break;
                }

                return Json(new { isError = false, msg = _msg });
            }
            else
            {
                return Json(new { isError = true, msg = "This EmailId is not registered with us!" });
            }
        }

        #endregion

        /*--------------------------------------Book Appoinment*/

        #region Book Appointment

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult BookAppointment()
        {
            BookAppointmentVM bookAppointmentDTO = new BookAppointmentVM();

            bookAppointmentDTO.appdate = DateTime.Today;
            bookAppointmentDTO.ftime = DateTime.Now.ToString("HH:mm");
            bookAppointmentDTO.ttime = DateTime.Now.AddMinutes(30).ToString("HH:mm");
            bookAppointmentDTO.ListAppoinmentAt = BookAppointmentVM.GetApptLocations();

            return View(bookAppointmentDTO);
        }

        [HttpPost]
        [ValidateUserAttribute]
        public ActionResult BookAppointment(BookAppointmentVM bookAppointmentDTO)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                int result = cm.BookAppointment(bookAppointmentDTO);

                if (result == 0)
                {

                    DateTime date = DateTime.ParseExact(DateTime.Now.ToString(), "dd-MM-yyyy h:mm:ss tt", CultureInfo.InvariantCulture);

                    MailContentsVM mailContents = new MailContentsVM();
                    mailContents.To = bookAppointmentDTO.emailid;
                    mailContents.Bcc = ClientInventory.GetSalesManEmailId();
                    mailContents.Message = "";
                    mailContents.Subject = "Appointment request-" + date.ToString("ddMMyyyy");

                    string msgBody = ComFunc.ReadHtml("Appointments.html", Convert.ToString(Session["Emailid"]), Convert.ToString(Session["ClientHandle_Location"]))
                        .Replace("`IP-Address`", Convert.ToString(Session["curRequestIp"])).Replace("`Url`", Request.Url.ToString().RootUrl())
                        .Replace("`Message`", mailContents.Message).Replace("`Name`", Convert.ToString(Session["clientname"]))
                        .Replace("`req-date`", bookAppointmentDTO.appdate.ToShortDateString()).Replace("`req-ftime`", bookAppointmentDTO.ftime).Replace("`req-ttime`", bookAppointmentDTO.ttime)
                        .Replace("`ClientFullAddress`", Convert.ToString(Session["ClientFullAddress"]));

                    int retval = SendMail.sendMailWithAuthentication(null, mailContents.To, null, mailContents.Bcc, mailContents.Subject, msgBody, null, null);

                    TempData["Message"] = "Appointment for your request has been added.."; TempData["AlertType"] = "0";

                    //return RedirectToAction("Index", "InventorySearch");
                    return Json(new { msg = "Your Appointment has been added..", iserror = "n" });
                }
                else
                {
                    return Json(new { msg = "Unfortunately Appointment not scheduled..", iserror = "y" });
                }
            }

            bookAppointmentDTO = new BookAppointmentVM();

            bookAppointmentDTO.appdate = DateTime.Today;
            bookAppointmentDTO.ftime = DateTime.Now.ToString("HH:mm");
            bookAppointmentDTO.ttime = DateTime.Now.AddMinutes(30).ToString("HH:mm");
            bookAppointmentDTO.ListAppoinmentAt = BookAppointmentVM.GetApptLocations();

            return View(bookAppointmentDTO);
        }

        #endregion

        /*--------------------------------------Edit User Profile*/

        #region EditUserProfile

        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult EditProfile()
        {
            EditProfileVM profile = new EditProfileVM();

            profile = ClientMaster.ClientProfile(Convert.ToString(Session["Clientcd"]), Convert.ToString(Session["Emailid"]));

            profile.LoginName = Convert.ToString(Session["Emailid"]);
            profile.ListTitles = EditProfileVM.GetTitles();
            profile.ListCountries = EditProfileVM.GetCountries();
            profile.ListBusinessTypes = EditProfileVM.GetBusineTypes();

            return View(profile);
        }

        [HttpPost]
        [ValidateUserAttribute]
        [ActionName("EditProfile")]
        public ActionResult EditProfile_Post(EditProfileVM profileObj)
        {
            if (ModelState.IsValid)
            {
                ClientMaster cm = new ClientMaster();
                profileObj.ClientCd = Convert.ToInt32(Session["ClientCd"]);
                profileObj.LoginName = Convert.ToString(Session["Emailid"]);
                int result = cm.UpdateClient(profileObj);

                switch (result)
                {
                    case 0: return Json(new { url = @Url.Action("Index", "Account"), iserror = false, msg = "Details has been modified successfully.." });
                    case 1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Member details have been found, Please contact to Administrator.." });
                    case -1: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Unfortunately Member details not registered.." });
                    default: return Json(new { url = @Url.Action("Index", "Account"), iserror = true, msg = "Please contact to Administrator.." });
                }
            }

            profileObj.ListTitles = EditProfileVM.GetTitles();
            profileObj.ListBusinessTypes = EditProfileVM.GetBusineTypes();
            profileObj.ListCountries = EditProfileVM.GetCountries();
            return View(profileObj);
        }
        #endregion
    }
}