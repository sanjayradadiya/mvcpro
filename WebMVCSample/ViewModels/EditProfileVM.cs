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
    public class EditProfileVM
    {
        public Int32 ClientCd { get; set; }

        [Display(Name = "Email")]
        public string LoginName { get; set; }

        public int Sequence { get; set; }

        [Required(ErrorMessage = "Company Name could not be blank..")]
        [Display(Name = "Company Name")]
        public string CompanyNm { get; set; }

        [Required]
        [Display(Name = "Title")]
        public string Title { get; set; }

        [Required(ErrorMessage = "First name should be required..")]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Last name should be required..")]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        [Display(Name = "Birth Date")]
        public DateTime? birthdate { get; set; }

        //[Required(ErrorMessage = "Designation could not be blank..")]
        [Display(Name = "Designation")]
        public string Designation { get; set; }

        //public string Terms { get; set; }

        //public decimal creditdays { get; set; }

        //public decimal Commission { get; set; }

        //public decimal Brokerage { get; set; }

        //public decimal PriceDiscount { get; set; }

        //public decimal Discount { get; set; }

        //public string PriceFormat { get; set; }

        //public string TaxDetails { get; set; }

        //[Required]
        //public string ReferenceFrom { get; set; }

        //[Required]
        [Display(Name = "Reference Through")]
        public string ReferenceThrough { get; set; }

        //[Required(ErrorMessage = "Address could not be balnk..")]
        public string Address { get; set; }

        [Required(ErrorMessage = "City could not be blank..")]
        public string City { get; set; }

        [Required(ErrorMessage = "State could not be blank..")]
        public string State { get; set; }

        //[Display(Name = "Postal Code")]
        //public string Zipcode { get; set; }

        [Required(ErrorMessage = "Country code could not be blank..")]
        public int? Country { get; set; }

        //[Display(Name = "Country Code")]
        //[Range(10, 9999)]
        //public string Phone_Countrycd { get; set; }

        //[Required(ErrorMessage = "STD code could not be blank..")]
        [Display(Name = "Std Code")]
        [Range(10, 99999)]
        public string Phone_STDcd { get; set; }

        [Required(ErrorMessage = "Phone no could not be balnk..")]
        //[Range(100, 999999)]
        [Display(Name = "Phone No")]
        public string Phone_No { get; set; }

        //public string Phone_Countrycd2 { get; set; }

        //public string Phone_STDCd2 { get; set; }

        //public string Phone_No2 { get; set; }

        //public string Fax_Countrycd { get; set; }

        //public string Fax_STDCd { get; set; }
        //public string Fax_No { get; set; }

        //[Display(Name = "Mobile Country Code")]
        //[Range(10, 9999)]
        //public string Mobile_CountryCd { get; set; }

        [Display(Name = "Mobile No")]
        //[Range(10, 9999999999)]
        public string Mobile_No { get; set; }

        //public string EmailID1 { get; set; }
        //public string EmailID2 { get; set; }
        //public string EmailID3 { get; set; }
        //public string all_emailid { get; set; }

        public string Website { get; set; }

        [Display(Name = "Business Type")]
        public string BusinessType { get; set; }

        //public DateTime CreatedOn { get; set; }
        //public decimal CreatedBy { get; set; }
        //public DateTime UpdatedOn { get; set; }
        //public int UpdatedBy { get; set; }
        //public string ApproveStatus { get; set; }
        //public DateTime ApproveStatusOn { get; set; }
        //public decimal ApproveStatusBy { get; set; }
        //public DateTime StatusUpdatedOn { get; set; }
        //public decimal StatusUpdatedBy { get; set; }
        //public string status { get; set; }
        //public string WholeStockAccess { get; set; }
        //public string bankdetails { get; set; }
        //public string routingdetails { get; set; }
        //public int handle_location { get; set; }
        //public int smid { get; set; }
        //public string emailstatus { get; set; }
        //public DateTime lastlogindate { get; set; }

        [Display(Name = "Skype Id")]
        public string skypeid { get; set; }

        //public string qqid { get; set; }
        //public string emailSubscr { get; set; }
        //public DateTime emailSubscrDate { get; set; }
        //public int UTypeID { get; set; }
        //public string UserRights { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> ListTitles { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> ListBusinessTypes { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> ListCountries { get; set; }

        public static IEnumerable<SelectListItem> GetTitles()
        {
            return (from Title s in Enum.GetValues(typeof(Title))
                    select new { ID = s, Name = s.ToString() }).Select(x => new SelectListItem { Text = x.ID.ToString() + ".", Value = x.Name });
        }

        public static IEnumerable<SelectListItem> GetBusineTypes()
        {
            return (from BusinessType s in Enum.GetValues(typeof(BusinessType))
                    select new { ID = s, Name = s.ToString() }).Select(x => new SelectListItem { Text = x.ID.ToString() + ".", Value = x.Name });
        }

        public static IEnumerable<SelectListItem> GetCountries()
        {
            string vQry = "select proccd countrycd,shortnm country from procmas where procgroup='country' and status='Y'";
            DataTable dt = ComFunc.excDataTable(vQry);
            //return dt.AsEnumerable().ToDictionary<DataRow, string, string>(row => row.Field<string>(0), row => row.Field<string>(1));
            return dt.AsEnumerable().Select(x => new Country { CountryCd = x.Field<decimal>("countrycd"), CountryNm = x.Field<string>("country") })
                .Select(x => new SelectListItem { Text = x.CountryNm, Value = Convert.ToString(x.CountryCd) });
        }
    }
}