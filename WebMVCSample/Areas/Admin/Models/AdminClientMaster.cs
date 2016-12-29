using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebInventory.Common;
using System.Text;
using System.Data.SqlClient;
using WebInventory.Areas.Admin.ViewModels;
using System.Web.Mvc;
using System.Globalization;

namespace WebInventory.Areas.Admin.Models
{
    public class AdminClientMaster
    {
        #region ClientMaster

        public static IEnumerable<SelectListItem> GetUserLevels()
        {

            string vQry = "SELECT PROCCD,SHORTNM FROM PROCMAS WHERE PROCGROUP='USERTYPE' AND STATUS='Y' AND PROCNM NOT IN('SUPER ADMIN')";
            DataTable dt = ComFunc.excDataTable(vQry);
            return dt.AsEnumerable().Select(x => new { utypeid = x.Field<decimal>("PROCCD"), utype = x.Field<string>("SHORTNM") })
                .Select(x => new SelectListItem { Text = x.utype, Value = Convert.ToString(x.utypeid) });
        }

        public DataTable GetClientDetails(string LoginName, int? ClientId = null)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT NULL SL,NULL ED,NULL DEL, LOGINNAME, CLIENTNAME, /*PASSWORD,*/ SALESMAN, LOCATION, LASTLOGGEDON, COMPANYNM, DESIGNATION, CONTACTNO, WEBSITE, CITY, COUNTRY, STATUSDESC,");
            sb.Append("NULL APPOINTMENTREQUEST, MAILTYPE, SC_CNT, BR_CNT, WL_CNT, NULL BULKIMPORT, CLIENTCD, TRACKED_IP, UTYPEID FROM VIEW_CLIENTDET");
            sb.Append(" WHERE 1=1 AND LOGINNAME NOT IN('GUEST','ADMIN') ");
            if (ClientId != null)
                sb.Append(" AND CLIENTCD IN ( @CLIENTCD )");
            if (!string.IsNullOrEmpty(LoginName))
                sb.Append(" AND LOGINNAME = @LOGINNAME");

            List<SqlParameter> SqlParams = new List<SqlParameter>() { };
            if (ClientId != null)
                SqlParams.Add(new SqlParameter("CLIENTCD", ClientId));
            if (!string.IsNullOrEmpty(LoginName))
                SqlParams.Add(new SqlParameter("LOGINNAME", LoginName));

            return ComFunc.excDataTable(sb.ToString(), SqlParams.ToArray(), CommandType.Text);
        }

        public int UpdateClient(ClientEditProfileVM profileObj)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@clientcd", profileObj.ClientCd));
            para.Add(new SqlParameter("@Title", profileObj.Title));
            para.Add(new SqlParameter("@FirstName", profileObj.FirstName));
            para.Add(new SqlParameter("@LastName", profileObj.LastName));
            para.Add(new SqlParameter("@birthdate", profileObj.birthdate));
            para.Add(new SqlParameter("@CompanyNm", profileObj.CompanyNm));
            para.Add(new SqlParameter("@Designation", profileObj.Designation));
            para.Add(new SqlParameter("@ReferenceThrough", profileObj.ReferenceThrough));
            para.Add(new SqlParameter("@Address", profileObj.Address));
            para.Add(new SqlParameter("@City", profileObj.City));
            para.Add(new SqlParameter("@State", profileObj.State));
            para.Add(new SqlParameter("@Countrycd", profileObj.Country));
            //para.Add(new SqlParameter("@Zipcode", profileObj.Zipcode ?? null));
            //para.Add(new SqlParameter("@Phone_Countrycd", profileObj.Phone_Countrycd));
            para.Add(new SqlParameter("@Phone_STDcd", profileObj.Phone_STDcd));
            para.Add(new SqlParameter("@Phone_No", profileObj.Phone_No));
            //para.Add(new SqlParameter("@Mobile_CountryCd", profileObj.Mobile_CountryCd));
            para.Add(new SqlParameter("@Mobile_No", profileObj.Mobile_No));
            para.Add(new SqlParameter("@EmailID1", profileObj.LoginName));
            para.Add(new SqlParameter("@all_emailid", profileObj.LoginName));
            para.Add(new SqlParameter("@Website", profileObj.Website));
            para.Add(new SqlParameter("@BusinessType", profileObj.BusinessType));
            para.Add(new SqlParameter("@UpdatedBy", profileObj.UpdatedBy));
            para.Add(new SqlParameter("@HANDLE_LOCATION", profileObj.handle_location));
            para.Add(new SqlParameter("@smid", profileObj.smid));
            para.Add(new SqlParameter("@SKYPEID", profileObj.skypeid));
            para.Add(new SqlParameter("@STATUS", profileObj.status));
            para.Add(new SqlParameter("@UTYPEID", profileObj.UTypeVal));
            para.Add(new SqlParameter("@EMAILSTATUS", profileObj.emailstatus));
            para.Add(new SqlParameter("@ISADMIN", true));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("update_ClientMaster", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);

        }

        public static ClientEditProfileVM ClientProfile(string ClientCd, string LoginName)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@ClientCd", ClientCd));
            para.Add(new SqlParameter("@LOGINNAME", LoginName));

            string Qry = "select ClientCd, Loginname, Title, FirstName, LastName, BirthDate, CompanyNm, Designation, Referencethrough, Address,City, State, ";
            Qry += "CountryCd, ZipCode, Phone_CountryCd, Phone_STDCd, Phone_No, Mobile_CountryCd, Mobile_No, Website, BusinessType, SkypeId, status, isnull(utypeid,0) as utypeid ";
            Qry += "from clientmaster where clientcd=@ClientCd AND LOGINNAME =@LOGINNAME";

            DataTable dt = ComFunc.excDataTable(Qry, para.ToArray(), CommandType.Text);

            ClientEditProfileVM editProfile = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.AsEnumerable().FirstOrDefault();

                editProfile = new ClientEditProfileVM()
                {
                    ClientCd = Convert.ToInt32(dr["ClientCd"]),
                    LoginName = Convert.ToString(dr["Loginname"]),
                    CompanyNm = Convert.ToString(dr["CompanyNm"]),
                    Title = Convert.ToString(dr["Title"]),
                    FirstName = Convert.ToString(dr["FirstName"]),
                    LastName = Convert.ToString(dr["LastName"]),
                    birthdate = Convert.ToDateTime(dr["BirthDate"]),
                    Designation = Convert.ToString(dr["Designation"]),
                    ReferenceThrough = Convert.ToString(dr["ReferenceThrough"]),
                    Address = Convert.ToString(dr["Address"]),
                    City = Convert.ToString(dr["City"]),
                    State = Convert.ToString(dr["State"]),
                    Country = Convert.ToInt32(dr["CountryCd"]),
                    //Zipcode = Convert.ToString(dr["Zipcode"]),
                    //Phone_Countrycd = Convert.ToString(dr["Phone_Countrycd"]),
                    Phone_STDcd = Convert.ToString(dr["Phone_STDcd"]),
                    Phone_No = Convert.ToString(dr["Phone_No"]),
                    //Mobile_CountryCd = Convert.ToString(dr["Mobile_CountryCd"]),
                    Mobile_No = Convert.ToString(dr["Mobile_No"]),
                    Website = Convert.ToString(dr["Website"]),
                    BusinessType = Convert.ToString(dr["BusinessType"]),
                    skypeid = Convert.ToString(dr["skypeid"]),
                    status = Convert.ToString(dr["status"]),
                    UTypeVal = Convert.ToInt32(dr["utypeid"])
                };
            }

            return editProfile;
        } /*Existing User profile edit end*/

        public int RemoveClient(string cliendId, string loginName, Int32 updatedBy)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@CLIENTCD", cliendId));
            para.Add(new SqlParameter("@LOGINNAME", loginName));
            para.Add(new SqlParameter("@UPDATEDBY", updatedBy));

            string vQry = "UPDATE CLIENTMASTER SET STATUS='N', UPDATEDBY=@UPDATEDBY, UPDATEDON=GETDATE() WHERE CLIENTCD=@CLIENTCD AND LOGINNAME=@LOGINNAME";
            return ComFunc.excNonQuery(vQry, para.ToArray(), CommandType.Text);
        }

        public static DataTable GetClientLoginNames(string loginName)
        {
            string pQry = "SELECT LOGINNAME VAL,LOGINNAME NM FROM CLIENTMASTER WHERE isnull(UTYPEID,0)<>1 AND LOGINNAME<>'GUEST'";

            List<SqlParameter> param = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(loginName))
            {
                pQry += " AND LOGINNAME = @LOGINNAME";
                param.Add(new SqlParameter("LOGINNAME", loginName));
            }

            return ComFunc.excDataTable(pQry, param.ToArray(), CommandType.Text);
        }
        #endregion

        #region AppointmentMaster

        public DataTable GetAppointDetails(string fDate, string tDate, string ApptStatus)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT NULL APPROVE, CASE STATUS WHEN 'P' THEN 'Pending' WHEN 'F' THEN 'Fixed' WHEN 'R' THEN 'Rejected' END AS STATUSDESC, APPID, EMAILID, COMPANYNAME, CONTACT1, CONTACT2, LOCATION, ");
            sb.Append("CURDATE AS APPOINTMENTON, FTIME +' - ' + TTIME AS APPTTIME, PERSONNAME, TOTPERSON, INTERESTED, REMARKS, STATUS ");
            sb.Append("FROM APPOINTMENTS ");
            sb.Append(" WHERE 1=1 ");
            if (!string.IsNullOrEmpty(fDate) && !string.IsNullOrEmpty(tDate))
                sb.Append(" AND CURDATE BETWEEN (@fdate) AND (@tdate)");
            if (!string.IsNullOrEmpty(ApptStatus))
                sb.Append(" AND STATUS = @APPTSTATUS");

            List<SqlParameter> SqlParams = new List<SqlParameter>() { };
            if (!string.IsNullOrEmpty(fDate) && !string.IsNullOrEmpty(tDate))
            {
                DateTime vStDate = DateTime.ParseExact(fDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                DateTime vendDate = DateTime.ParseExact(tDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);

                SqlParams.Add(new SqlParameter("@fDate", vStDate));
                SqlParams.Add(new SqlParameter("@tdate", vendDate));
            }

            if (!string.IsNullOrEmpty(ApptStatus))
                SqlParams.Add(new SqlParameter("APPTSTATUS", ApptStatus));

            return ComFunc.excDataTable(sb.ToString(), SqlParams.ToArray(), CommandType.Text);
        }

        public DataRow GetAppointDetailsById(string apptId)
        {
            StringBuilder sb = new StringBuilder();

            if (string.IsNullOrEmpty(apptId)) { return null; }

            sb.Append("SELECT APPID, EMAILID, CURDATE AS APPOINTMENTON, FTIME, TTIME ,STATUS ");
            sb.Append("FROM APPOINTMENTS ");
            sb.Append(" WHERE 1=1 ");
            List<SqlParameter> SqlParams = new List<SqlParameter>() { };

            if (!string.IsNullOrEmpty(apptId))
                SqlParams.Add(new SqlParameter("APPID", apptId));

            DataTable dt = ComFunc.excDataTable(sb.ToString(), SqlParams.ToArray(), CommandType.Text);

            return dt.AsEnumerable().FirstOrDefault();
        }

        public int SetAppointmentStatus(int pApptId, string pStatus, string pClientCd)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@AppId", pApptId));
            para.Add(new SqlParameter("@Location", ""));
            para.Add(new SqlParameter("@CompanyName", ""));
            para.Add(new SqlParameter("@PersonName", ""));
            para.Add(new SqlParameter("@emailid", ""));
            para.Add(new SqlParameter("@contact1", ""));
            para.Add(new SqlParameter("@contact2", ""));
            para.Add(new SqlParameter("@interested", ""));
            para.Add(new SqlParameter("@appdate", ""));
            para.Add(new SqlParameter("@totperson", -1));
            para.Add(new SqlParameter("@remarks", ""));
            para.Add(new SqlParameter("@status", pStatus));
            para.Add(new SqlParameter("@ftime", ""));
            para.Add(new SqlParameter("@ttime", ""));
            para.Add(new SqlParameter("@updatedby", pClientCd));
            para.Add(new SqlParameter("@flag", "UPDATE"));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("sp_appointments", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);

        }

        #endregion

        #region GuestMaster

        public DataTable GetGuestDetails(string gEmailId)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT NULL REMOVE, ROW_NUMBER() OVER (ORDER BY EMAILID) ROWNUM, FIRSTNM+ ' '+ LASTNM AS GUESTNM, EMAILID, COMPANYNM, PHONE_COUNTRYCD + ' ' + PHONE_STDCD + ' ' + PHONE_NO AS PHONENO, MOBILE_NO, ");
            sb.Append("CREATEDON,LASTLOGINTIME, COUNTLOGS, ISDELETED ");
            sb.Append("FROM GUESTMASTER ");
            sb.Append(" WHERE 1=1 ");

            List<SqlParameter> SqlParams = new List<SqlParameter>() { };
            if (!string.IsNullOrEmpty(gEmailId))
            {
                sb.Append(" AND EMAILID = @EMAILID");

                SqlParams.Add(new SqlParameter("@EMAILID", gEmailId));
            }

            return ComFunc.excDataTable(sb.ToString(), SqlParams.ToArray(), CommandType.Text);
        }

        public int RemoveGuest(string pEmailId, string pCompanyNm, string pStatus)
        {
            string vQry = "UPDATE GUESTMASTER SET ISDELETED = @ISDELETED WHERE EMAILID = @EMAILID AND COMPANYNM = @COMPANYNM";

            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@EMAILID", pEmailId));
            para.Add(new SqlParameter("@COMPANYNM", pCompanyNm));
            para.Add(new SqlParameter("@ISDELETED", "Y"));

            return ComFunc.excNonQuery(vQry, para.ToArray(), CommandType.Text);
        }
        #endregion

        #region EmailSubScribers

        public DataTable GetEmailSubScrbDets(string gEmailId, string pStatus)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT ROW_NUMBER() OVER (ORDER BY EMAILID) ROWNUM, EMAILID, REGISTEREDON, STATUS ");
            sb.Append("FROM AUTOEMAILSUBSCRIBERS ");
            sb.Append(" WHERE 1=1 ");

            List<SqlParameter> SqlParams = new List<SqlParameter>() { };
            if (!string.IsNullOrEmpty(gEmailId))
            {
                sb.Append(" AND EMAILID = @EMAILID");

                SqlParams.Add(new SqlParameter("@EMAILID", gEmailId));
            }
            if (!string.IsNullOrEmpty(pStatus))
            {
                sb.Append(" AND STATUS = @STATUS");

                SqlParams.Add(new SqlParameter("@STATUS", pStatus));
            }

            return ComFunc.excDataTable(sb.ToString(), SqlParams.ToArray(), CommandType.Text);
        }

        public int UpdateEmailSubScrbr(string pEmailId)
        {
            string vQry = "UPDATE AUTOEMAILSUBSCRIBERS SET STATUS = @STATUS WHERE EMAILID = @EMAILID";

            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@EMAILID", pEmailId));

            return ComFunc.excNonQuery(vQry, para.ToArray(), CommandType.Text);
        }
        #endregion
    }
}