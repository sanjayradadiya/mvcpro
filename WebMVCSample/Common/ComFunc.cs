using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Web;
using System.IO;

namespace WebInventory.Common
{
    public class ComFunc : DbContext
    {
        public static string sqlConStr = "Data Source=192.168.0.173;Initial Catalog=sjogani;User ID=sa;Password=a_123456;Connection TimeOut=600";
        //public static string sqlConStr = "Data Source=143.95.252.18;Initial Catalog=mak_mgtest;User ID=Web_mgtest;Password=Web@123;Connection TimeOut=600";
        //public static string sqlConStr = "Data Source=143.95.252.18;Initial Catalog=mak_mg;Persist Security Info=True;User ID=Web_inv_mg;password=Web@123";
        public static SqlConnection sqlCon;
        public static SqlCommand sqlCom;
        public static SqlDataAdapter sqlDa;
        public static DataSet Ds;
        public static DataTable Dt;

        public ComFunc()
            : base(sqlConStr)
        {
        }

        private static SqlCommand PrepareSqlCommand(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            sqlCom = new SqlCommand() { Connection = sqlCon, CommandText = pQry, CommandType = comType };
            if (sqlParams != null) sqlCom.Parameters.AddRange(sqlParams);
            return sqlCom;
        }

        public static int excNonQuery(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            using (sqlCon = new SqlConnection(sqlConStr))
            {
                using (sqlCom = PrepareSqlCommand(pQry, sqlParams, comType))
                {
                    sqlCon.Open();
                    return sqlCom.ExecuteNonQuery();
                }
            }
        }

        public static object excScalar(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            using (sqlCon = new SqlConnection(sqlConStr))
            {
                using (sqlCom = PrepareSqlCommand(pQry, sqlParams, comType))
                {
                    sqlCon.Open();
                    return sqlCom.ExecuteScalar();
                }
            }
        }

        public static SqlDataReader excReader(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            using (sqlCon = new SqlConnection(sqlConStr))
            {
                using (sqlCom = PrepareSqlCommand(pQry, sqlParams, comType))
                {
                    sqlCon.Open();
                    return sqlCom.ExecuteReader();
                }
            }
        }

        public static DataSet excDataSet(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            Ds = new DataSet();
            using (sqlCon = new SqlConnection(sqlConStr))
            {
                using (sqlCom = PrepareSqlCommand(pQry, sqlParams, comType))
                {
                    using (sqlDa = new SqlDataAdapter())
                    {
                        sqlDa.SelectCommand = sqlCom;
                        sqlDa.Fill(Ds);
                    }
                }
            }
            return Ds;
        }

        public static DataTable excDataTable(string pQry, SqlParameter[] sqlParams = null, CommandType comType = CommandType.Text)
        {
            DataTable Dt = new DataTable();
            using (sqlCon = new SqlConnection(sqlConStr))
            {
                using (sqlCom = PrepareSqlCommand(pQry, sqlParams, comType))
                {
                    using (sqlDa = new SqlDataAdapter())
                    {
                        sqlDa.SelectCommand = sqlCom;
                        sqlDa.Fill(Dt);
                    }
                }
            }
            return Dt;
        }

        public static decimal mydivide(decimal pval1, decimal pval2, int pround)
        {
            decimal vval;
            try
            {
                if (pval2 != 0)
                {
                    vval = Math.Round(pval1 / pval2, pround);
                }
                else
                {
                    return 0;
                }
                return vval;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public static string ReadHtml(string fileName, string ClientLoginName, string HandleLocation = "")
        {
            string htmlData = string.Empty;

            HttpContext curContext = HttpContext.Current;
            string filePath = curContext.Server.MapPath("~/MailFormats/" + fileName);
            if (File.Exists(filePath))
            {
                using (StreamReader reader = new StreamReader(filePath))
                {
                    htmlData = reader.ReadToEnd();

                    string rootUrl = "http://" + curContext.Request.Url.Authority;
                    string companyLogo = "<img src='" + rootUrl + "/Content/Images/logo.png' alt='" + rootUrl + "' />";

                    string companyAddress = string.Empty;

                    if (!string.IsNullOrEmpty(ClientLoginName))
                    {
                        companyAddress = GetCompanyAddressByclient(ClientLoginName, HandleLocation);
                    }
                    else
                    {
                        companyAddress = GetCompanyAddress();
                    }

                    htmlData = htmlData.Replace("`Logo`", companyLogo).Replace("`CompanyAddress`", companyAddress);

                }
            }
            return htmlData;
        }

        private static string GetCompanyAddressByclient(string ClientLoginName, string HandleLocation)
        {
            string Qry = string.Format("select dbo.GetHandleLocationByLoginName('{0}','{1}')", ClientLoginName, HandleLocation);
            var res = ComFunc.excScalar(Qry, null, CommandType.Text);
            return Convert.ToString(res);
        }

        private static string GetCompanyAddress()
        {
            string Qry = string.Format("select address from companydet where type=@HandleLocation");
            List<SqlParameter> sqlParams = new List<SqlParameter>() { 
                new SqlParameter("@HandleLocation","MUMBAI")
            };
            var res = ComFunc.excScalar(Qry, sqlParams.ToArray(), CommandType.Text);
            return Convert.ToString(res);
        }
    }
}