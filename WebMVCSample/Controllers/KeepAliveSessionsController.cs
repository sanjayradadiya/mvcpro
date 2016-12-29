using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebInventory.Controllers
{
    public class KeepAliveSessionsController : Controller
    {
        //
        // GET: /KeepAliveSessions/
        [HttpPost]
        public ActionResult Index()
        {
            Request.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMinutes(10);
            return Json(new { respid = Request.Cookies["ASP.NET_SessionId"].Value, result = new HttpStatusCodeResult(200, "OK") }, JsonRequestBehavior.AllowGet);
        }

    }
}