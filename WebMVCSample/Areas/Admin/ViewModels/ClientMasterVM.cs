using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebInventory.Areas.Admin.ViewModels
{
    public class ClientMasterVM
    {
        public string LoginName { get; set; }
        public string ClientName { get; set; }
        public string CompanyName { get; set; }
        public string ContactNo { get; set; }
        public int WatchList { get; set; }
        public int ViewCart { get; set; }
        public int ViewOrder { get; set; }
        public string EmailStatus { get; set; }
        public string Website { get; set; }
        public string Country { get; set; }
        public string Designation { get; set; }
        public string SalesMan { get; set; }
        public string HandlingLocation { get; set; }
        public string Status { get; set; }
        public int ClientId { get; set; }

    }
}