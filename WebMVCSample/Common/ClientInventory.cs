using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebInventory.Common
{
    public class ClientInventory
    {
        public static List<string> GetClientCart(string ClienctCd, string CartType)
        {
            List<string> clientCurCartList = new List<string>();
            string Qry = "SELECT SC_STONEID FROM SHOPPINGCART WHERE SC_STATUS <>'O' AND SC_CLIENTCD=@CLIENTCD AND SC_STATUS=@STATUS";

            List<SqlParameter> sqlParams = new List<SqlParameter>() { 
                new SqlParameter("@CLIENTCD",ClienctCd),
                new SqlParameter("@STATUS",CartType)
            };

            DataTable dt = ComFunc.excDataTable(Qry, sqlParams.ToArray(), CommandType.Text);

            clientCurCartList = dt.AsEnumerable().Select(row => row.Field<string>("SC_STONEID")).ToList();

            return clientCurCartList;
        }

        public static string InsertCart(string ClienctCd, string CartType, string RefNos, decimal OffearRate, decimal OffearDisc)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>() { 
                new SqlParameter("@SC_clientcd",ClienctCd),
                new SqlParameter("@SC_Status",CartType),
                new SqlParameter("@SC_stoneidS",RefNos),
                new SqlParameter("@sc_offerrate",OffearRate),
                new SqlParameter("@sc_offerdisc",OffearDisc),
            };

            SqlParameter outParam = new SqlParameter("@ReturnVal", "OK");
            outParam.Direction = ParameterDirection.Output;

            sqlParams.Add(outParam);

            ComFunc.excNonQuery("spInsertShoppingCart", sqlParams.ToArray(), CommandType.StoredProcedure);

            return string.Join(",", Convert.ToString(outParam.Value).Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList());
        }

        public static string GetSalesManEmailId()
        {
            string ClientCd = Convert.ToString(HttpContext.Current.Session["Clientcd"]);
            string Qry = "SELECT EMAILID FROM USERMAS WHERE USERCD = (SELECT MAX(SMID) FROM CLIENTMASTER WHERE CLIENTCD=@CLIENTCD)";
            List<SqlParameter> sqlParams = new List<SqlParameter>(){
                new SqlParameter("@CLIENTCD",ClientCd)
            };

            var retval = ComFunc.excScalar(Qry, sqlParams.ToArray(), CommandType.Text);
            if (retval != null)
            {
                return Convert.ToString(retval);
            }
            return Convert.ToString(HttpContext.Current.Session["g-infoMail"]);
        }
    }
}