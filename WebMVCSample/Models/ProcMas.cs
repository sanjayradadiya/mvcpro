using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebInventory.Common;
using System.Data.SqlClient;

namespace WebInventory.Models
{
    public class ProcMas
    {
        public string ProcGroup { get; set; }
        public int ProcCd { get; set; }
        public string ProcNm { get; set; }
        public string ShortMm { get; set; }
        public int Ord { get; set; }
        public string Status { get; set; }

        public Dictionary<string, string> GetAllShapes()
        {
            string vQry = "SELECT PROCNM, PROCNM TXT FROM PROCMAS WHERE PROCGROUP='SHAPE' AND STATUS='N' ORDER BY ORD";
            DataTable dt = ComFunc.excDataTable(vQry);
            return dt.AsEnumerable().ToDictionary<DataRow, string, string>(row => row.Field<string>(0), row => row.Field<string>(1));
        }

        public DataTable GetProcesses()
        {
            string vQry = "SELECT * FROM PROCMAS WHERE STATUS='Y' ORDER BY ORD";
            return ComFunc.excDataTable(vQry);
        }

        public DataTable GetClientSavedList(string ClientCd)
        {
            string vQry = "SELECT SEARCHNAME,SID FROM USERSEARCHHISTORY WHERE AUTO='Y' AND CID=@CLIENTCD ORDER BY SID DESC";
            List<SqlParameter> fparams = new List<SqlParameter>() { 
                new SqlParameter("@CLIENTCD", ClientCd)
            };
            return ComFunc.excDataTable(vQry, fparams.ToArray(), CommandType.Text);
        }
    }
}