using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Linq;
using System.Data.SqlClient;
using WebInventory.Common;

namespace WebInventory.Models
{
    public class InventoryModel
    {
        public string Location { get; set; }
        public string Certificate { get; set; }
        public string CertNo { get; set; }
        public string Stoneid { get; set; }
        public string Shape { get; set; }
        public decimal? cts { get; set; }
        public string Color { get; set; }
        public string Clarity { get; set; }
        public string Cut { get; set; }
        public string Polish { get; set; }
        public string Sym { get; set; }
        public decimal? Raparate { get; set; }
        public Nullable<decimal> Askrate_fc { get; set; }
        public decimal? Askdisc_fc { get; set; }
        public decimal? Askamt_fc { get; set; }
        public string Flshortnm { get; set; }
        public decimal? Depth { get; set; }
        public decimal? Diatable { get; set; }
        public string Measurement { get; set; }
        public string Girdle { get; set; }
        public string Certno { get; set; }
        public string Inscription { get; set; }
        public Nullable<decimal> Dia { get; set; }
        public string Girdleper { get; set; }
        public string Girdle_condition { get; set; }
        public string Ha { get; set; }
        public string Inclusion { get; set; }
        public string Flourence { get; set; }
        public Nullable<decimal> Crown { get; set; }
        public Nullable<decimal> Crownangle { get; set; }
        public Nullable<decimal> Crownheight { get; set; }
        public Nullable<decimal> Pavilion { get; set; }
        public Nullable<decimal> Pavangle { get; set; }
        public Nullable<decimal> Pavheight { get; set; }
        public Nullable<decimal> Star_length { get; set; }
        public Nullable<decimal> Lower_half { get; set; }
        public string Key_to_symbol { get; set; }
        public string Fl_color { get; set; }
        public string Culet { get; set; }
        public string Colordesc { get; set; }
        public string Barcode { get; set; }
        public decimal? Length { get; set; }
        public decimal? Width { get; set; }
        public Nullable<decimal> Height { get; set; }
        public string Luster { get; set; }
        public string Milky { get; set; }
        public string Shade { get; set; }
        public string Natts { get; set; }
        public string Natural { get; set; }
        public string Pair { get; set; }
        public Nullable<int> Ordshape { get; set; }
        public Nullable<int> Ordcolor { get; set; }
        public Nullable<int> Ordclarity { get; set; }
        public Nullable<int> Ordcut { get; set; }
        /* public Nullable<System.DateTime> Curdate { get; set; } */
        public string Status { get; set; }
        public Nullable<decimal> Rapaamt { get; set; }
        public string Fl_Color_Shortnm { get; set; }
        public string Legend1 { get; set; }
        public string Legend2 { get; set; }
        public string Legend3 { get; set; }
        public Nullable<decimal> Ratio { get; set; }
        public string Report_comment { get; set; }
        public string Rapsize { get; set; }
        public string Fancy_color_status { get; set; }
        public string New_cert { get; set; }

        private StringBuilder PrimaryQuery(string ClientCd = "0")
        {
            StringBuilder vQry = new StringBuilder();

            string vaskrate_fc = string.Empty, vaskdisc_fc = string.Empty, vaskamt_fc = string.Empty;

            vQry.Append(" SELECT null DETAILS,  LOCATION, LEGEND1+','+ LEGEND2+','+DBO.GETLEGEND3STATUS(@CLIENTCD,STONEID,LEGEND3) AS LEGENDS, CERTIFICATE, ");
            vQry.Append(" CASE CERTIFICATE WHEN 'GIA' THEN '<a href=''http://www.gia.edu/cs/Satellite?reportno='+ certno +'&childpagename=GIA%2FPage%2FReportCheck&pagename=GIA%2FDispatcher&c=Page&cid=1355954554547'' target=''_blank''>'+ certno +'</a>' ");
            vQry.Append(" WHEN 'IGI' THEN '<a href=''http://www.igiworldwide.com/verify.php?r='+CERTNO+''' target=''_blank''>'+ certno +'</a>'");
            vQry.Append(" WHEN 'HRD' THEN '<a href=''https://my.hrdantwerp.com/?record_number='+CERTNO+'+&weight='+ Convert(varchar,CTS) +'&L='' target=''_blank''>' ELSE CERTNO END AS CERTNO, NULL REFDET,");
            vQry.Append(" STONEID, SHAPE, CTS, COLOR, CLARITY, CUT, POLISH, SYM, FLSHORTNM, RAPARATE, ISNULL(ASKRATE_FC,0) AS ASKRATE_FC, ");
            vQry.Append(" ISNULL(askdisc_fc,0) AS ASKDISC_FC, ISNULL(askamt_fc,0) AS ASKAMT_FC, DEPTH, DIATABLE, MEASUREMENT, GIRDLE, CERTNO, INSCRIPTION, ");
            vQry.Append(" DIA, GIRDLEPER, GIRDLE_CONDITION, HA, INCLUSION, FLOURENCE, CROWN, CROWNANGLE, CROWNHEIGHT, PAVILION, PAVANGLE, PAVHEIGHT, STAR_LENGTH, ");
            vQry.Append(" LOWER_HALF, KEY_TO_SYMBOL, FL_COLOR, CULET, COLORDESC, BARCODE, LENGTH, WIDTH, HEIGHT, LUSTER, MILKY, SHADE, NATTS, NATURAL, PAIR, ");
            vQry.Append(" ORDSHAPE, ORDCOLOR, ORDCLARITY, ORDCUT, RAPAAMT, FL_COL_SHORTNM, LEGEND1, LEGEND2, DBO.GETLEGEND3STATUS(@CLIENTCD,STONEID,LEGEND3) AS LEGEND3, ");
            vQry.Append(" RATIO, REPORT_COMMENT, RAPSIZE, FANCY_COLOR_STATUS, NEW_CERT, CERTNO AS CERTINO, STATUS ");

            vQry.Replace("@CLIENTCD", ClientCd);

            vQry.Append(" FROM VIEW_NEW_GRADDET ");

            return vQry;
        }

        public DataTable GetResults(string ClientCd = "0", string pWhere = null)
        {
            StringBuilder vQry = PrimaryQuery(ClientCd);

            if (!string.IsNullOrEmpty(pWhere))
            {
                vQry.Append(" WHERE 1=1" + pWhere);
            }
            return ComFunc.excDataTable(vQry.ToString());
        }

        public DataTable GetCartByClientCD(string pClientCD, string pScStatus, string pWhere = null)
        {
            StringBuilder vQry = PrimaryQuery(pClientCD);

            /* PARENT QUERY REFERENCED AS 'VG' TO MAINTAIN SHOPPINGCART RELATION */
            vQry.Append(" AS VG ");

            vQry.Append(" JOIN SHOPPINGCART SC ");
            vQry.Append(" ON VG.STONEID=SC.SC_STONEID ");
            vQry.Append(string.Format(" WHERE SC_CLIENTCD={0} AND SC_STATUS='{1}'", pClientCD, pScStatus));

            if (!string.IsNullOrEmpty(pWhere))
            {
                vQry.Append(pWhere);
            }

            return ComFunc.excDataTable(vQry.ToString());
        }

        public static int SaveSearchParams(string[][] selector, string isAuto, string ClientCd, string searchName = null)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();
            foreach (string[] selectParam in selector)
            {
                string key = selectParam[0];
                switch (key)
                {
                    case "Shape": sqlParams.Add(new SqlParameter("SHAPE", selectParam[1])); break;
                    case "StoneNo": sqlParams.Add(new SqlParameter("STONEID", selectParam[1])); break;
                    case "CertNo": sqlParams.Add(new SqlParameter("CERTNO", selectParam[1])); break;
                    case "Weight": sqlParams.Add(new SqlParameter("CTS", selectParam[1])); break;
                    case "mWeight": sqlParams.Add(new SqlParameter("MCTS", selectParam[1])); break;
                    case "Col": sqlParams.Add(new SqlParameter("COLOR", selectParam[1])); break;
                    case "mCol": sqlParams.Add(new SqlParameter("MCOLOR", selectParam[1])); break;
                    case "Clr": sqlParams.Add(new SqlParameter("CLARITY", selectParam[1])); break;
                    case "mClr": sqlParams.Add(new SqlParameter("MCLARITY", selectParam[1])); break;
                    case "Cut": sqlParams.Add(new SqlParameter("CUT", selectParam[1])); break;
                    case "mCut": sqlParams.Add(new SqlParameter("MCUT", selectParam[1])); break;
                    case "Pol": sqlParams.Add(new SqlParameter("POLISH", selectParam[1])); break;
                    case "mPol": sqlParams.Add(new SqlParameter("MPOLISH", selectParam[1])); break;
                    case "Sym": sqlParams.Add(new SqlParameter("SYM", selectParam[1])); break;
                    case "mSym": sqlParams.Add(new SqlParameter("MSYM", selectParam[1])); break;
                    case "Fl": sqlParams.Add(new SqlParameter("FL", selectParam[1])); break;
                    case "mFl": sqlParams.Add(new SqlParameter("MFL", selectParam[1])); break;
                    case "Girdle": sqlParams.Add(new SqlParameter("GIRDLEPER", selectParam[1])); break;
                    case "Culet": sqlParams.Add(new SqlParameter("culet", selectParam[1])); break;
                    case "Table": sqlParams.Add(new SqlParameter("TABLEPER", selectParam[1])); break;
                    case "Depth": sqlParams.Add(new SqlParameter("DEPTHPER", selectParam[1])); break;
                    case "Location": sqlParams.Add(new SqlParameter("LOCATION", selectParam[1])); break;
                    case "Lab": sqlParams.Add(new SqlParameter("CERTIFICATE", selectParam[1])); break;
                    case "Rate": sqlParams.Add(new SqlParameter("RATE", selectParam[1])); break;
                    case "Amt": sqlParams.Add(new SqlParameter("AMT", selectParam[1])); break;
                    case "Rapo": sqlParams.Add(new SqlParameter("RAPARATE", selectParam[1])); break;
                    case "RapAmt": sqlParams.Add(new SqlParameter("RAPAAMT", selectParam[1])); break;
                    case "Length": sqlParams.Add(new SqlParameter("lengthmm", selectParam[1])); break;
                    case "Width": sqlParams.Add(new SqlParameter("widthmm", selectParam[1])); break;
                    case "Height": sqlParams.Add(new SqlParameter("depthmm", selectParam[1])); break;
                    case "Ratio": sqlParams.Add(new SqlParameter("RATIOMM", selectParam[1])); break;
                    default: break;
                }
            }
            if (string.IsNullOrEmpty(searchName))
                sqlParams.Add(new SqlParameter("SearchName", DateTime.Now.ToString()));
            else
                sqlParams.Add(new SqlParameter("SearchName", searchName));

            sqlParams.Add(new SqlParameter("CID", ClientCd));
            sqlParams.Add(new SqlParameter("DISCPER", null));
            sqlParams.Add(new SqlParameter("INCLUSION", null));
            sqlParams.Add(new SqlParameter("flcolor", null));
            sqlParams.Add(new SqlParameter("SHOWONLY", null));
            sqlParams.Add(new SqlParameter("ORD1", null));
            sqlParams.Add(new SqlParameter("ORD2", null));
            sqlParams.Add(new SqlParameter("ORD3", null));
            sqlParams.Add(new SqlParameter("ORD4", null));
            sqlParams.Add(new SqlParameter("ORD5", null));
            sqlParams.Add(new SqlParameter("ORD6", null));
            sqlParams.Add(new SqlParameter("PAGESIZE", null));
            sqlParams.Add(new SqlParameter("AUTO", isAuto));
            sqlParams.Add(new SqlParameter("usertype", null));
            sqlParams.Add(new SqlParameter("uid", null));
            sqlParams.Add(new SqlParameter("isFancy", null));

            SqlParameter retParam = new SqlParameter("@ReturnVal", SqlDbType.Int, 0);
            retParam.Direction = ParameterDirection.Output;

            SqlParameter retParam2 = new SqlParameter("@sid", SqlDbType.Int, 0);
            retParam2.Direction = ParameterDirection.Output;

            sqlParams.Add(retParam);
            sqlParams.Add(retParam2);
            ComFunc.excNonQuery("INSERT_USERSEARCHHISTORY", sqlParams.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam2.Value);
        }

        public static string SetSavedSearchParams(Dictionary<string, string> sparams)
        {
            Dictionary<string, string> retParams = new Dictionary<string, string>();
            foreach (var item in sparams)
            {
                string keyfield = string.Empty;
                switch (item.Key)
                {
                    case "SHAPE": keyfield = "Shape"; break;
                    case "STONEID": keyfield = "StoneNo"; break;
                    case "CERTNO": keyfield = "CertNo"; break;
                    case "CTS": keyfield = "Weight"; break;
                    case "MCTS": keyfield = "mWeight"; break;
                    case "COLOR": keyfield = "Col"; break;
                    case "MCOLOR": keyfield = "mCol"; break;
                    case "CLARITY": keyfield = "Clr"; break;
                    case "MCLARITY": keyfield = "mClr"; break;
                    case "CUT": keyfield = "Cut"; break;
                    case "MCUT": keyfield = "mCut"; break;
                    case "POLISH": keyfield = "Pol"; break;
                    case "MPOLISH": keyfield = "mPol"; break;
                    case "SYM": keyfield = "Sym"; break;
                    case "MSYM": keyfield = "mSym"; break;
                    case "FL": keyfield = "Fl"; break;
                    case "MFL": keyfield = "mFl"; break;
                    case "GIRDLEPER": keyfield = "Girdle"; break;
                    case "culet": keyfield = "Culet"; break;
                    case "TABLEPER": keyfield = "Table"; break;
                    case "DEPTHPER": keyfield = "Depth"; break;
                    case "LOCATION": keyfield = "Location"; break;
                    case "CERTIFICATE": keyfield = "Lab"; break;
                    case "RATE": keyfield = "Rate"; break;
                    case "AMT": keyfield = "Amt"; break;
                    case "RAPARATE": keyfield = "Rapo"; break;
                    case "RAPAAMT": keyfield = "RapAmt"; break;
                    case "lengthmm": keyfield = "Length"; break;
                    case "widthmm": keyfield = "Width"; break;
                    case "depthmm": keyfield = "Height"; break;
                    case "RATIOMM": keyfield = "Ratio"; break;
                }
                if (keyfield != "" && Convert.ToString(item.Value) != "")
                    retParams.Add(keyfield, item.Value);
            }
            return string.Join("@", retParams.Select(x => x.Key + ":" + x.Value).ToArray());
        }

        public static Dictionary<string, string> GetSavedListCollection(string ClientCd, string SavedId, string SavedName)
        {
            StringBuilder vQry = new StringBuilder();
            vQry.Append("SELECT SID, SEARCHNAME, SAVEDON, CID, SHAPE, CTS, MCTS, COLOR, MCOLOR, CLARITY, MCLARITY, CUT, MCUT, POLISH, MPOLISH, SYM, MSYM, FL, MFL, ");
            vQry.Append("CERTIFICATE, CERTNO, RATE, DISCPER, AMT, RAPARATE, RAPAAMT, INCLUSION, STONEID, TABLEPER, DEPTHPER, GIRDLEPER, LENGTHMM, WIDTHMM, DEPTHMM, ");
            vQry.Append("LOCATION, FLCOLOR, CULET, RATIOMM, SHOWONLY, ORD1, ORD2, ORD3, ORD4, ORD5, ORD6, PAGESIZE, AUTO, USERTYPE, UID, ISFANCY ");
            vQry.Append("FROM USERSEARCHHISTORY ");
            vQry.Append("WHERE AUTO='Y' AND CID = @CLIENTCD AND SID = @SID ");

            List<SqlParameter> sqlParams = new List<SqlParameter>() {
                new SqlParameter("@CLIENTCD",ClientCd),
                new SqlParameter("@SID",SavedId),
            };

            Dictionary<string, string> selectParams = new Dictionary<string, string>();
            DataTable dt = ComFunc.excDataTable(vQry.ToString(), sqlParams.ToArray(), CommandType.Text);

            foreach (DataColumn dc in dt.Columns)
            {
                selectParams.Add(dc.ColumnName, dt.Rows[0][dc.ColumnName].ToString());
            }

            return selectParams;
        }

        public static int RemoveCartByClient(string ClientCd, List<string> RefNos, string CartType)
        {
            string vCartType = CartType.ToUpper() == "CART" ? "I" : "B";
            //string Qry = "UPDATE SHOPPINGCART SET SC_STATUS = 'O' WHERE SC_CLIENTCD = @SC_CLIENTCD AND SC_STATUS = @SC_STATUS AND SC_STONEID IN ({0})";
            string Qry = "DELETE FROM SHOPPINGCART WHERE SC_CLIENTCD = @SC_CLIENTCD AND SC_STATUS = @SC_STATUS AND SC_STONEID IN ({0})";

            List<SqlParameter> sqlParams = new List<SqlParameter>(){
                new SqlParameter("@SC_CLIENTCD", ClientCd),
                new SqlParameter("@SC_STATUS", vCartType),
            };

            int INDX = 0;
            List<string> nameParamList = new List<string>();
            foreach (string vRefNo in RefNos)
            {
                var paraname = "@PREFNM" + INDX.ToString();
                sqlParams.Add(new SqlParameter(paraname, vRefNo));
                nameParamList.Add(paraname);
                INDX++;
            }

            Qry = string.Format(Qry, string.Join(",", nameParamList));

            return ComFunc.excNonQuery(Qry, sqlParams.ToArray(), CommandType.Text);
        }
    }
}