using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web.Mvc;

namespace WebInventory.Areas.Admin.ViewModels
{
    public class CompanyDetVM
    {
        [Required(ErrorMessage = "Company Location is Required")]
        [Display(Name = "Company Loaction")]
        public string cType { get; set; }

        [AllowHtml]
        [Required(ErrorMessage = "Company Address is Required")]
        [Display(Name = "Address")]
        public string cAddress { get; set; }

        [Display(Name = "Bank Details")]
        public string cBankDetails { get; set; }

        [Display(Name = "Routing Details")]
        public string cRoutingDetails { get; set; }

        [Display(Name = "Phone Details")]
        public string cPhoneDetails { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> LocationList { get; set; }
    }
}