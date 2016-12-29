using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebInventory.Common;
using WebInventory.ViewModels;

namespace WebInventory.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        #region LoginMain
        public ActionResult Index()
        {
            LoginVM loginDTO = new LoginVM();
            Session.Abandon();
            if (Request.Cookies["webcrd"] != null)
            {
                GetAuthCookie(Request.Cookies["webcrd"], loginDTO);
            }
            return View(loginDTO);
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

        #region UserSignUP

        [HttpGet]
        [AllowAnonymous]
        public ActionResult SignUp()
        {
            return RedirectToAction("SignUp", "Account");
        }

        #endregion

        #region ForgotPassword

        [AllowAnonymous]
        [AcceptVerbs(HttpVerbs.Get), ActionName("ForgotPassword")]
        public ActionResult ForgotPassword()
        {
            return RedirectToAction("ForgotPassword", "Account");
        }

        #endregion
    }
}
