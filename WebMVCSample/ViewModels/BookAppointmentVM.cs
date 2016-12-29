using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using WebInventory.Common;

namespace WebInventory.ViewModels
{
    public class BookAppointmentVM
    {
        [Required(ErrorMessage = "Please select Appointment at..")]
        [Display(Name = "Appointment At")]
        public string Location { get; set; }

        [Required(ErrorMessage = "Company name could not be blank..")]
        [Display(Name = "Company Name")]
        public string CompanyName { get; set; }

        [Required(ErrorMessage = "Person name could not be blank..")]
        [Display(Name = "Sales Person")]
        public string PersonName { get; set; }

        [Required(ErrorMessage = "Email Id could not be blank..")]
        [Display(Name = "Email ID")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Enter valid email id..")]
        [RegularExpression(@"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}", ErrorMessage = "Please enter valid email id..")]
        public string emailid { get; set; }

        [Required(ErrorMessage = "Contact No could not be blank..")]
        [Display(Name = "Contact No")]
        [DataType(DataType.PhoneNumber)]
        public string contact1 { get; set; }

        [Display(Name = "Office No")]
        [DataType(DataType.PhoneNumber)]
        public string contact2 { get; set; }

        [Required(ErrorMessage = "Ineterested in could not be blank..")]
        [Display(Name = "Purpose")]
        public string interested { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Appointment Date")]
        //[DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        [Required(ErrorMessage = "Appointment Date could not be blank..")]
        public DateTime appdate { get; set; }

        [Required(ErrorMessage = "No of Visitors could not be blank..")]
        [Display(Name = "No of Visitors")]

        [Range(typeof(int), "1", "10", ErrorMessage = "No of persons should be between 1 and 10..")]
        public string totperson { get; set; }

        public string remarks { get; set; }

        [Required(ErrorMessage = "From time could not be blank..")]
        [Display(Name = "From Time ")]
        [DataType(DataType.Time)]
        public string ftime { get; set; }

        [Required(ErrorMessage = "To time could not be blank..")]
        [Display(Name = "To Time")]
        [DataType(DataType.Time)]
        public string ttime { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> ListAppoinmentAt { get; set; }

        public static IEnumerable<SelectListItem> GetApptLocations()
        {
            string Qry = "SELECT SHORTNM,PROCNM FROM PROCMAS WHERE PROCGROUP='LOCATION' AND PROCNM NOT IN ('LAB','INDIA')";
            DataTable dt = ComFunc.excDataTable(Qry);

            return dt.AsEnumerable().Select(row => new SelectListItem { Text = Convert.ToString(row["PROCNM"]), Value = Convert.ToString(row["SHORTNM"]) }).ToList();
        }
    }
}