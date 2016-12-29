using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebMVCSample.Models
{
    public class ClientMaster
    {
        public int CLIENTCD { get; set; }
        public string LoginName { get; set; }
        public string Password { get; set; }
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime birthdate { get; set; }
        public string CompanyNm { get; set; }
        public string Designation { get; set; }
        public string Terms { get; set; }
        public decimal creditdays { get; set; }
        public decimal Commission { get; set; }
        public decimal Brokerage { get; set; }
        public decimal PriceDiscount { get; set; }
        public decimal Discount { get; set; }
        public string PriceFormat { get; set; }
        public string TaxDetails { get; set; }
        public string ReferenceFrom { get; set; }
        public string ReferenceThrough { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zipcode { get; set; }
        public string Countrycd { get; set; }
        public string Phone_Countrycd { get; set; }
        public string Phone_STDcd { get; set; }
        public string Phone_No { get; set; }
        public string Phone_Countrycd2 { get; set; }
        public string Phone_STDCd2 { get; set; }
        public string Phone_No2 { get; set; }
        public string Fax_Countrycd { get; set; }
        public string Fax_STDCd { get; set; }
        public string Fax_No { get; set; }
        public string Mobile_CountryCd { get; set; }
        public string Mobile_No { get; set; }
        public string EmailID1 { get; set; }
        public string EmailID2 { get; set; }
        public string EmailID3 { get; set; }
        public string all_emailid { get; set; }
        public string Website { get; set; }
        public string BusinessType { get; set; }
        public DateTime CreatedOn { get; set; }
        public decimal CreatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
        public int UpdatedBy { get; set; }
        public string ApproveStatus { get; set; }
        public DateTime ApproveStatusOn { get; set; }
        public decimal ApproveStatusBy { get; set; }
        public DateTime StatusUpdatedOn { get; set; }
        public decimal StatusUpdatedBy { get; set; }
        public string status { get; set; }
        public string WholeStockAccess { get; set; }
        public string bankdetails { get; set; }
        public string routingdetails { get; set; }
        public int handle_location { get; set; }
        public int smid { get; set; }
        public string emailstatus { get; set; }
        public DateTime lastlogindate { get; set; }
        public string skypeid { get; set; }
        public string qqid { get; set; }
        public string emailSubscr { get; set; }
        public DateTime emailSubscrDate { get; set; }
        public int UTypeID { get; set; }
        public string UserRights { get; set; }
    }

    public enum Title
    {
        Mr,
        Mrs,
        Miss
    };
}