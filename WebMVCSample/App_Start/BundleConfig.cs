using System.Web;
using System.Web.Optimization;

namespace WebInventory
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/Scripts/jquery-1.11.3.min.js")); 
            //"~/Scripts/jquery-{version}.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include("~/Scripts/bootstrap.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/datatable").Include(
            "~/Scripts/JDatatables11012/js/jquery.dataTables.min.js", "~/Scripts/JDatatables11012/js/dataTables.jqueryui.min.js",
            "~/Scripts/jquery-ui-1.8.24.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/uploader").Include(
            "~/Scripts/fileUploader/fileinput.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include("~/Scripts/jquery.validate.min.js",
                "~/Scripts/jquery.validationEngine-en.js", "~/Scripts/jquery.validationEngine.js"));

            /*------------------------------------------------------------------------------------*/
            //bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
            //            "~/Scripts/jquery-ui-{version}.js"));

            //bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
            //            "~/Scripts/jquery.unobtrusive*",
            //            "~/Scripts/jquery.validate*"));
            /*------------------------------------------------------------------------------------*/

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/css")
                .Include("~/Content/site.css", "~/Content/bootstrap.min.css"));

            bundles.Add(new StyleBundle("~/Content/datatable_css")
                .Include("~/Content/themes/smoothness/jquery-ui.css",
                    "~/Content/JDatatables11012/css/dataTables.jqueryui.min.css",
                    "~/Content/JDatatables11012/css/select.jqueryui.min.css"
            ));

            bundles.Add(new StyleBundle("~/Content/fileInputBundle")
                .Include("~/Content/fileUploader/fileinput.min.css", "~/Content/fileUploader/customfileInput.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));

            BundleTable.EnableOptimizations = true;
        }
    }
}