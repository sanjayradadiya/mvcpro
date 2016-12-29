using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebInventory.Filters
{
    public class ValidateUserAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContextBase context = filterContext.HttpContext;
            if (context.Session["Clientcd"] == null)
            {
                if (HttpContext.Current.Request.Url.Host.ToLower().Contains("inventory"))
                {
                    filterContext.HttpContext.Response.Redirect(ViewModels.WebSiteSettings.Global_Website, true);
                }
                else if (HttpContext.Current.Request.Url.Host.ToLower().Contains("admin"))
                {
                    filterContext.HttpContext.Response.Redirect("/Admin", true);
                }
                else
                {
                    filterContext.HttpContext.Response.Redirect("/", true);
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}