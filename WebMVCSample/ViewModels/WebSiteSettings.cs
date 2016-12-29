
namespace WebInventory.ViewModels
{
    public class WebSiteSettings
    {
        private static string _Website;

        public static string Global_Website
        {
            get { return _Website ?? "mothergems.in"; }
            set { _Website = value; }
        }

        private static string _InfoMail;
        public static string Global_InfoMail
        {
            get { return _InfoMail ?? "info@mothergems.in"; }
            set { _InfoMail = value; }
        }
    }
}