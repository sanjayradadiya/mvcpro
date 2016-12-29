using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebInventory.Filters
{
    public class RedirectOnErrorAttribute : ActionFilterAttribute
    {
        public RedirectOnErrorAttribute()
        {
            ErrorMessage = "An error occurred while processing your request.";
        }

        /// <summary>
        /// Gets or sets the controller to redirect to.
        /// </summary>
        public string ReturnController { get; set; }

        /// <summary>
        /// Gets or sets the action to redirect to.
        /// </summary>
        public string ReturnAction { get; set; }

        /// <summary>
        /// Gets or sets the error message.
        /// </summary>
        public string ErrorMessage { get; set; }

        /// <summary>
        /// Redirects the user to an error screen if an exception is thrown.
        /// </summary>
        /// <param name="filterContext">The filter context.</param>
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.Exception != null && !filterContext.ExceptionHandled)
            {
                string controller = ReturnController;
                string action = ReturnAction;
                if (String.IsNullOrWhiteSpace(controller))
                {
                    controller = (string)filterContext.RequestContext.RouteData.Values["controller"];
                }
                if (String.IsNullOrWhiteSpace(action))
                {
                    action = "Index";
                }
                UrlHelper helper = new UrlHelper(filterContext.RequestContext);
                string url = helper.Action("Index", "Acount");
                filterContext.Result = new RedirectResult(url);
                filterContext.ExceptionHandled = true;
            }
            base.OnActionExecuted(filterContext);
    }
    }
}