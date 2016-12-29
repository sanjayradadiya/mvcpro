using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using WebInventory.Areas.Admin.ViewModels;
using WebInventory.Common;

namespace WebInventory.Areas.Admin.Models
{
    public class ProcessMaster
    {
        /*------------------------------------------------------process master for all processes (excluding color)*/
        //  ISCHANGEABLE =0 stands for TRUE and =1 stands for FALSE

        public static IEnumerable<SelectListItem> GetProcGroups()
        {

            string vQry = "SELECT DISTINCT PROCGROUP TXT,PROCGROUP SHORTNM FROM PROCMAS WHERE PROCGROUP NOT IN ('SHAPE','COLOR','FL_COLOR','FLOURENCE_COLOR') AND ISCHANGEABLE=1";
            DataTable dt = ComFunc.excDataTable(vQry);
            return dt.AsEnumerable().Select(x => new { procShrtNm = x.Field<string>("SHORTNM"), procNm = x.Field<string>("TXT") })
                .Select(x => new SelectListItem { Text = x.procShrtNm, Value = x.procNm });
        }

        public DataTable GetProcDetails()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT NULL ED, NULL DEL, PROCGROUP, PROCNM, SHORTNM, ORD, STATUS, PROCCD ");
            sb.Append(" FROM PROCMAS");
            sb.Append(" WHERE PROCGROUP NOT IN ('SHAPE','COLOR','FL_COLOR','FLOURENCE_COLOR') AND ISCHANGEABLE=1");
            sb.Append(" ORDER BY PROCGROUP, ORD ");

            return ComFunc.excDataTable(sb.ToString(), null, CommandType.Text);
        }

        public static int AddProcDets(ProcMasVM procObj)
        {
            return FireProcMasEvents(procObj, "INSERT");
        }

        public static int UpdateProcDets(ProcMasVM procObj)
        {
            return FireProcMasEvents(procObj, "UPDATE");
        }

        public static int DeleteProcDets(ProcMasVM procObj)
        {
            return FireProcMasEvents(procObj, "DELETE");
        }

        private static int FireProcMasEvents(ProcMasVM procObj, string pFlag)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@PPROCGROUP", procObj.mProcGrp));
            para.Add(new SqlParameter("@PPROCCD", procObj.PrcId));
            para.Add(new SqlParameter("@ORD", procObj.mPrcOrd));
            para.Add(new SqlParameter("@PROCNM", procObj.mPrcNm));
            para.Add(new SqlParameter("@PSHORTNM", procObj.mPrcShortNm));
            para.Add(new SqlParameter("@PSTATUS", procObj.mPrcStatus));
            para.Add(new SqlParameter("@FLAG", pFlag));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("spPROCMas_Event", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);
        }

        /*------------------------------------------------------process master for Color*/

        public DataTable GetColorDetails()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT NULL ED, NULL DEL, PROCNM, SHORTNM, ORD, STATUS, FANCY_COLOR_STATUS ISFANCY, PROCCD ");
            sb.Append(" FROM PROCMAS");
            sb.Append(" WHERE PROCGROUP = 'COLOR' AND ISCHANGEABLE=1");
            sb.Append(" ORDER BY ORD ");

            return ComFunc.excDataTable(sb.ToString(), null, CommandType.Text);
        }

        public static int AddColorDets(ColorProcMasVM procObj)
        {
            return FireColorEvents(procObj, "INSERT");
        }

        public static int UpdateColorDets(ColorProcMasVM procObj)
        {
            return FireColorEvents(procObj, "UPDATE");
        }

        public static int DeleteColorDets(ColorProcMasVM procObj)
        {
            return FireColorEvents(procObj, "DELETE");
        }

        private static int FireColorEvents(ColorProcMasVM procObj, string pFlag)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@PPROCCD", procObj.PrcId));
            para.Add(new SqlParameter("@ORD", procObj.mPrcOrd));
            para.Add(new SqlParameter("@PROCNM", procObj.mPrcNm));
            para.Add(new SqlParameter("@PSHORTNM", procObj.mPrcShortNm));
            para.Add(new SqlParameter("@PSTATUS", procObj.mPrcStatus));
            para.Add(new SqlParameter("@PISFANCY", procObj.mPrcIsFancy));
            para.Add(new SqlParameter("@FLAG", pFlag));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("spColorMas_Event", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);
        }

        public DataTable GetSettingsDet()
        {
            StringBuilder Qry = new StringBuilder();
            Qry.Append("SELECT ROW_NUMBER() OVER (ORDER BY COLNM) AS R, COLNM,VAL, NULL EDIT FROM ( ");
            Qry.Append("SELECT 'NEW ARRIVAL DAYS' AS COLNM, NEW_ARRIVAL_DAYS AS VAL FROM SETTINGS UNION ALL ");
            Qry.Append("SELECT 'SHOPPING CART LIMIT DAYS' AS COLNM, SC_DELETE_DAYS AS VAL FROM SETTINGS UNION ALL ");
            Qry.Append("SELECT 'BUY REQUEST LIMIT DAYS' AS COLNM, SCBR_DELETE_DAYS AS VAL FROM SETTINGS UNION ALL ");
            Qry.Append("SELECT 'BID LIMIT DAYS' AS COLNM, BIDLIMITVALUE AS VAL FROM SETTINGS UNION ALL ");
            Qry.Append("SELECT 'CLIENT DEACTIVATION DAYS' AS COLNM, CLIENT_DEACTIVATE_DAYS AS VAL FROM SETTINGS");
            Qry.Append(" ) data");

            return ComFunc.excDataTable(Qry.ToString(), null, CommandType.Text);
        }

        public static int UpdateSettingsDet(string colNm, string val)
        {
            string column = string.Empty;
            switch (colNm)
            {
                case "NEW ARRIVAL DAYS": column = "NEW_ARRIVAL_DAYS"; break;
                case "SHOPPING CART LIMIT DAYS": column = "SC_DELETE_DAYS"; break;
                case "BUY REQUEST LIMIT DAYS": column = "SCBR_DELETE_DAYS"; break;
                case "BID LIMIT DAYS": column = "BIDLIMITVALUE"; break;
                case "CLIENT DEACTIVATION DAYS": column = "CLIENT_DEACTIVATE_DAYS"; break;
            }

            string Qry = "UPDATE SETTINGS SET " + column + " = @COL_VALUE";

            List<SqlParameter> param = new List<SqlParameter>(){
                new SqlParameter("@COL_VALUE",val)
            };

            return ComFunc.excNonQuery(Qry, param.ToArray(), CommandType.Text);
        }
    }
}