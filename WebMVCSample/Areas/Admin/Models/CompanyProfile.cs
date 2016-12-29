using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using WebInventory.Areas.Admin.ViewModels;
using WebInventory.Common;

namespace WebInventory.Areas.Admin.Models
{
    public class CompanyProfile
    {
        public static IEnumerable<SelectListItem> GetLocations()
        {
            string vQry = "SELECT PROCNM VAL,SHORTNM NM FROM PROCMAS WHERE PROCGROUP='LOCATION'";
            DataTable dt = ComFunc.excDataTable(vQry);
            return dt.AsEnumerable().Select(x => new { utypeid = x.Field<string>("VAL"), utype = x.Field<string>("NM") })
                .Select(x => new SelectListItem { Text = x.utype, Value = Convert.ToString(x.utypeid) });
        }

        public static DataRow GetLocations(string ptype)
        {
            string vQry = "SELECT TYPE,ADDRESS,BANKDETAILS,ROUTINGDETAILS,PHONEDETAILS FROM COMPANYDET WHERE 1=1 ";

            List<SqlParameter> param = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(ptype))
            {
                vQry += " AND TYPE = @TYPE";

                param.Add(new SqlParameter("@TYPE", ptype));
            }

            DataTable dt = ComFunc.excDataTable(vQry, param.ToArray(), CommandType.Text);
            return dt.AsEnumerable().FirstOrDefault();
        }

        public static int setCompanyDets(CompanyDetVM companyObj)
        {
            string vQry = "UPDATE COMPANYDET SET ADDRESS = @ADDRESS, BANKDETAILS = @BANKDETAILS, ";
            vQry += " ROUTINGDETAILS = @ROUTINGDETAILS, PHONEDETAILS = @PHONEDETAILS ";
            vQry += " WHERE 1=1 ";
            vQry += " AND TYPE = @TYPE ";

            List<SqlParameter> param = new List<SqlParameter>() { 
                new SqlParameter("@TYPE", companyObj.cType),
                new SqlParameter("@ADDRESS", companyObj.cAddress),
                new SqlParameter("@BANKDETAILS", companyObj.cBankDetails),
                new SqlParameter("@ROUTINGDETAILS", companyObj.cRoutingDetails),
                new SqlParameter("@PHONEDETAILS", companyObj.cPhoneDetails),
            };

            return ComFunc.excNonQuery(vQry, param.ToArray(), CommandType.Text);
        }
    }
}