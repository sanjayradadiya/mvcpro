using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebInventory.Filters
{
    public class UserLevelAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContextBase context = filterContext.HttpContext;
            if (Convert.ToInt32(context.Session["LoginType"]) == 0)
            {
                if (HttpContext.Current.Request.Url.Host.ToLower().Contains("inventory"))
                {
                    filterContext.HttpContext.Response.Redirect(ViewModels.WebSiteSettings.Global_Website, true);
                }
                else
                {
                    filterContext.HttpContext.Response.Redirect("/Admin", true);
                }

                //filterContext.HttpContext.Response.Redirect("/Admin", true);
            }

            base.OnActionExecuting(filterContext);
        }
    }
}