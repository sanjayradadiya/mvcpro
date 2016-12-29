using System;
using System.Collections.Generic;
using System.Linq;

namespace WebInventory.Common
{
    public class OperatorHelper
    {
        public static void whereBuilder(string[] selector, ref string resVal)
        {
            string key = selector[0];
            switch (key)
            {
                case "StoneNo": resVal += OperatorBuilder("STONEID", selector[1].Replace(" ", ","), "IN", "STRING"); break;
                case "CertNo": resVal += OperatorBuilder("CERTNO", selector[1].Replace(" ", ","), "IN", "STRING"); break;
                case "Shape": resVal += OperatorBuilder("SHAPE", selector[1], "IN", "STRING"); break;
                case "Weight": resVal += OperatorBuilder("CTS", selector[1], "BETWEEN", "STRING"); break;
                case "mWeight": resVal += mCtsBetWeenOperator("CTS", selector[1]); break;
                case "Col": resVal += OperatorBuilder("ORDCOLOR", selector[1], "BETWEEN", "INT"); break;
                case "mCol": resVal += OperatorBuilder("ORDCOLOR", selector[1], "IN", "INT"); break;
                case "Clr": resVal += OperatorBuilder("ORDCLARITY", selector[1], "BETWEEN", "INT"); break;
                case "mClr": resVal += OperatorBuilder("ORDCLARITY", selector[1], "IN", "INT"); break;
                case "Cut": resVal += OperatorBuilder("ORDCUT", selector[1], "BETWEEN", "INT"); break;
                case "mCut": resVal += OperatorBuilder("ORDCUT", selector[1], "IN", "INT"); break;
                case "Pol": resVal += OperatorBuilder("ORDPOLISH", selector[1], "BETWEEN", "INT"); break;
                case "mPol": resVal += OperatorBuilder("ORDPOLISH", selector[1], "IN", "INT"); break;
                case "Sym": resVal += OperatorBuilder("ORDSYM", selector[1], "BETWEEN", "INT"); break;
                case "mSym": resVal += OperatorBuilder("ORDSYM", selector[1], "IN", "INT"); break;
                case "Fl": resVal += OperatorBuilder("ORDFL", selector[1], "BETWEEN", "INT"); break;
                case "mFl": resVal += OperatorBuilder("ORDFL", selector[1], "IN", "INT"); break;
                case "Girdle": resVal += OperatorBuilder("ORDGIRDLE", selector[1], "BETWEEN", "INT"); break;
                case "Culet": resVal += OperatorBuilder("ORDCULET", selector[1], "BETWEEN", "INT"); break;
                case "Table": resVal += OperatorBuilder("DIATABLE", selector[1], "BETWEEN", "INT"); break;
                case "Depth": resVal += OperatorBuilder("DEPTH", selector[1], "BETWEEN", "INT"); break;
                case "Location": resVal += OperatorBuilder("LOCATION", selector[1], "EQUAL", "STRING"); break;
                case "Lab": resVal += OperatorBuilder("CERTIFICATE", selector[1], "EQUAL", "STRING"); break;
                case "Rate": resVal += OperatorBuilder("ASKRATE_FC", selector[1], "BETWEEN", "INT"); break;
                case "Rapo": resVal += OperatorBuilder("RAPARATE", selector[1], "BETWEEN", "INT"); break;
                case "Length": resVal += OperatorBuilder("LENGTH", selector[1], "BETWEEN", "INT"); break;
                case "Width": resVal += OperatorBuilder("WIDTH", selector[1], "BETWEEN", "INT"); break;
                case "Height": resVal += OperatorBuilder("HEIGHT", selector[1], "BETWEEN", "INT"); break;
                case "ShowOnly": resVal += ShowOnlyWhere(selector[1]); break;
                default: resVal += ""; break;
            }
        }

        public static string OperatorBuilder(string keyField, string valFeild, string Operator, string datatype)
        {
            if (!string.IsNullOrEmpty(valFeild))
            {
                switch (Operator.ToUpper())
                {
                    case "B":
                    case "BETWEEN":
                        string[] valfieldVals = valFeild.Split(new char[] { ',' });
                        if (valfieldVals.Length < 2) return null;
                        if (!string.IsNullOrEmpty(valfieldVals[0]) && !string.IsNullOrEmpty(valfieldVals[1]))
                        {
                            if (datatype.ToUpper() == "STRING")
                                return " AND (" + keyField + " BETWEEN '" + valfieldVals[0] + "' AND '" + valfieldVals[1] + "')";
                            else
                                return " AND (" + keyField + " BETWEEN " + valfieldVals[0] + " AND " + valfieldVals[1] + ")";
                        }
                        return null;

                    case "E":
                    case "EQUAL":
                        return " AND " + keyField + " = '" + valFeild + "'";

                    case "I":
                    case "IN":
                        if (datatype.ToUpper() == "STRING")
                            return " AND " + keyField + " IN ('" + valFeild.Replace(",", "','") + "')";
                        else
                            return " AND " + keyField + " IN (" + valFeild.Replace(",", ",") + ")";

                    default: return null;
                }
            }
            return null;
        }

        //public static string mCtsBetWeenOperator(string keyField, string valFeild)
        //{
        //    var item = valFeild.Split(new char[] { ',' }).ToList().ChunkBy(2);

        //    if (item != null)
        //    {
        //        string retval = string.Empty;
        //        foreach (List<string> chunkVals in item) { if (Convert.ToString(chunkVals[0]) != "") { retval += " OR (" + keyField + " BETWEEN '" + chunkVals[0] + "' AND '" + chunkVals[1] + "') "; } }
        //        if (retval != "") return " AND (" + retval.Substring(3) + " )";
        //        return "";
        //    }
        //    return null;
        //}

        public static string mCtsBetWeenOperator(string keyField, string valFeild)
        {
            var item = valFeild.Split(new char[] { '^' }).ToList();

            if (item != null)
            {
                string retval = string.Empty;
                foreach (string chunkVals in item)
                {
                    string[] vals = chunkVals.Split(new char[] { '-' });
                    if (Convert.ToString(vals[0]) != "")
                    {
                        retval += " OR (" + keyField + " BETWEEN '" + vals[0] + "' AND '" + vals[1] + "') ";
                    }
                }
                if (retval != "") return " AND (" + retval.Substring(3) + " )";
                return "";
            }
            return null;
        }

        private static string ShowOnlyWhere(string valField)
        {
            string retVal = string.Empty;
            switch (valField)
            {
                case "A": retVal = " AND LEGEND3 ='A'"; break;
                case "U": retVal = " AND LEGEND3 ='U'"; break;
                case "N": retVal = " AND LEGEND1 ='N'"; break;
                case "NA": retVal = " AND LEGEND3 ='N' AND LEGEND1 ='A'"; break;
                case "NU": retVal = " AND LEGEND3 ='N' AND LEGEND1 ='U'"; break;
                case "NC": retVal = " AND NEW_CERT ='Y'"; break;
            }
            return retVal;
        }
    }
}