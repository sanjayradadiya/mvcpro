using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebInventory.Areas.Admin.ViewModels
{
    public class GuestMasterVM
    {
        [Required(ErrorMessage = "First name is required")]
        [Display(Name = "First Name")]
        public string FirstNm { get; set; }

        [Required(ErrorMessage = "Last name is required")]
        [Display(Name = "Last Name")]
        public string LastNm { get; set; }

        [Required(ErrorMessage = "Email Id is required")]
        [Display(Name = "Email Id")]
        public string EmailId { get; set; }

        [Required(ErrorMessage = "Company name is required")]
        [Display(Name = "Company Name")]
        public string CompanyNm { get; set; }

        [Required(ErrorMessage = "Phone country code is required")]
        [Display(Name = "Phone Country Cd")]
        public int PhoneCountryCd { get; set; }

        [Required(ErrorMessage = "Phone std code is required")]
        [Display(Name = "Phone Std Cd")]
        public int PhoneStdCd { get; set; }

        [Required(ErrorMessage = "Phone no is required")]
        [Display(Name = "Phone No")]
        public int PhoneNo { get; set; }

        [Required(ErrorMessage = "Mobile no is required")]
        [Display(Name = "Mobile No")]
        public string MobileNo { get; set; }
    }
}