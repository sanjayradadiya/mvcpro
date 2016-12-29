using System;
using System.Collections.Generic;
using System.Web;
using System.Linq;
using System.Data.SqlClient;
using WebInventory.ViewModels;
using System.Data;

namespace WebInventory.Common
{
    public class ClientMaster
    {
        ComFunc cf = new ComFunc();

        #region ClientRegistration

        public int InsertClient(RegistrationVM registerObj)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@LoginName", registerObj.LoginName));
            para.Add(new SqlParameter("@Password", registerObj.Password));
            para.Add(new SqlParameter("@Title", registerObj.Title));
            para.Add(new SqlParameter("@FirstName", registerObj.FirstName));
            para.Add(new SqlParameter("@LastName", registerObj.LoginName));
            para.Add(new SqlParameter("@birthdate", registerObj.birthdate));
            para.Add(new SqlParameter("@CompanyNm", registerObj.CompanyNm));
            para.Add(new SqlParameter("@Designation", registerObj.Designation));
            para.Add(new SqlParameter("@Address", registerObj.Address));
            para.Add(new SqlParameter("@City", registerObj.City));
            para.Add(new SqlParameter("@State", registerObj.State));
            //para.Add(new SqlParameter("@Zipcode", registerObj.Zipcode));
            para.Add(new SqlParameter("@Countrycd", registerObj.Country));
            //para.Add(new SqlParameter("@Phone_Countrycd", registerObj.Phone_Countrycd));
            para.Add(new SqlParameter("@Phone_STDcd", registerObj.Phone_STDcd));
            para.Add(new SqlParameter("@Phone_No", registerObj.Phone_No));
            para.Add(new SqlParameter("@Phone_Countrycd2", null));
            para.Add(new SqlParameter("@Phone_STDCd2", null));
            para.Add(new SqlParameter("@Phone_No2", null));
            para.Add(new SqlParameter("@Fax_Countrycd", null));
            para.Add(new SqlParameter("@Fax_STDCd", null));
            para.Add(new SqlParameter("@Fax_No", null));
            //para.Add(new SqlParameter("@Mobile_CountryCd", registerObj.Mobile_CountryCd));
            para.Add(new SqlParameter("@Mobile_No", registerObj.Mobile_No));
            para.Add(new SqlParameter("@EmailID1", registerObj.LoginName));
            para.Add(new SqlParameter("@EmailID2", null));
            para.Add(new SqlParameter("@EmailID3", null));
            para.Add(new SqlParameter("@Website", registerObj.Website));
            para.Add(new SqlParameter("@all_emailid", registerObj.LoginName));
            para.Add(new SqlParameter("@CreatedBy", 0));
            para.Add(new SqlParameter("@bankdetails", null));
            para.Add(new SqlParameter("@routingdetails", null));
            para.Add(new SqlParameter("@SkypeId", registerObj.skypeid));
            para.Add(new SqlParameter("@QQId", null));

            if (!String.IsNullOrEmpty(HttpContext.Current.Request.QueryString["ur"]))
            {
                if (Convert.ToString(HttpContext.Current.Request.QueryString["ur"]).ToLower() == "y")
                {
                    para.Add(new SqlParameter("@status", "Y"));
                    para.Add(new SqlParameter("@ReferenceThrough", null));
                    para.Add(new SqlParameter("@BusinessType", null));
                }
            }
            else
            {
                para.Add(new SqlParameter("@status", "P"));
                para.Add(new SqlParameter("@ReferenceThrough", registerObj.ReferenceThrough));
                para.Add(new SqlParameter("@BusinessType", registerObj.BusinessType));
                para.Add(new SqlParameter("@utypeid", "0"));
            }

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("Insert_ClientMaster", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);

        } /*InsertClient method end*/

        public DataTable CheckUser(LoginVM loginObj)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@Username", loginObj.Username));
            para.Add(new SqlParameter("@password", loginObj.Password));

            return ComFunc.excDataTable("sp_isClientValid", para.ToArray(), CommandType.StoredProcedure);
        } /*Existing User Checking method end*/

        public int ClientLoginHistory(int clientCd, string trackIp, string SessionId, string ActionType, int LogId)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>() { 
                new SqlParameter("CLIENTCD",clientCd),
                new SqlParameter("CSessionID",SessionId),
                new SqlParameter("TRACK_IP",trackIp),
                new SqlParameter("CAction",ActionType),
                new SqlParameter("CLogID",LogId),
            };

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            sqlParams.Add(retParam);

            ComFunc.excNonQuery("SP_CLIENTLOGINHISTORY", sqlParams.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);
        }

        public static Object CheckEmail(string EmailId)
        {
            string Qry = "select ClientCd from clientmaster where Loginname =@EmailId";
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@EmailId", EmailId));

            return ComFunc.excScalar(Qry, para.ToArray(), CommandType.Text);
        } /*Existing User Checking method end*/

        public static EditProfileVM ClientProfile(string ClientCd, string LoginName)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@ClientCd", ClientCd));
            para.Add(new SqlParameter("@LoginName", LoginName));

            string Qry = "select ClientCd, Loginname, Title, FirstName, LastName, BirthDate, CompanyNm, Designation, Referencethrough, Address,City, State, ";
            Qry += "CountryCd, ZipCode, Phone_CountryCd, Phone_STDCd, Phone_No, Mobile_CountryCd, Mobile_No, Website, BusinessType, SkypeId ";
            Qry += "from clientmaster where clientcd=@ClientCd and loginname=@LoginName";

            DataTable dt = ComFunc.excDataTable(Qry, para.ToArray(), CommandType.Text);

            EditProfileVM editProfile = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.AsEnumerable().FirstOrDefault();

                editProfile = new EditProfileVM()
                {
                    Sequence = Convert.ToInt32(dr["ClientCd"]),
                    LoginName = Convert.ToString(dr["Loginname"]),
                    CompanyNm = Convert.ToString(dr["CompanyNm"]),
                    Title = Convert.ToString(dr["Title"]),
                    FirstName = Convert.ToString(dr["FirstName"]),
                    LastName = Convert.ToString(dr["LastName"]),
                    birthdate = dr["BirthDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["BirthDate"]),
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
                };
            }

            return editProfile;
        } /*Existing User profile edit end*/

        #endregion

        #region ForgotPassword

        public string ForgotPassword(ForgotPasswordVM forgotPasswordObj)
        {
            string Qry = "select dbo.GetClientPassword(@Emailid)";
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@Emailid", forgotPasswordObj.RegisteredEmail));

            return Convert.ToString(ComFunc.excScalar(Qry, para.ToArray(), CommandType.Text));
        } /*Forgot Password method end*/

        #endregion

        #region ResetPassword

        public int ResetPassword(ResetPasswordVM resetPasswordObj)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@LoginName", resetPasswordObj.RegisteredEmail));
            para.Add(new SqlParameter("@OldPassword", resetPasswordObj.OldPassword));
            para.Add(new SqlParameter("@NewPassword", resetPasswordObj.NewPassword));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("ClientChangePassword", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);
        }

        #endregion

        #region BookAppointMents
        public int BookAppointment(BookAppointmentVM bookAppointmentObj)
        {
            var para = new List<SqlParameter>();
            para.Add(new SqlParameter("@AppId", "0"));
            para.Add(new SqlParameter("@Location", bookAppointmentObj.Location));
            para.Add(new SqlParameter("@CompanyName", bookAppointmentObj.CompanyName));
            para.Add(new SqlParameter("@PersonName", bookAppointmentObj.PersonName));
            para.Add(new SqlParameter("@emailid", bookAppointmentObj.emailid));
            para.Add(new SqlParameter("@contact1", bookAppointmentObj.contact1));
            para.Add(new SqlParameter("@contact2", bookAppointmentObj.contact2));
            para.Add(new SqlParameter("@interested", bookAppointmentObj.interested));
            para.Add(new SqlParameter("@appdate", bookAppointmentObj.appdate));
            para.Add(new SqlParameter("@totperson", bookAppointmentObj.totperson));
            para.Add(new SqlParameter("@remarks", bookAppointmentObj.remarks));
            para.Add(new SqlParameter("@status", "P"));
            para.Add(new SqlParameter("@ftime", bookAppointmentObj.ftime));
            para.Add(new SqlParameter("@ttime", bookAppointmentObj.ttime));
            para.Add(new SqlParameter("@updatedby", null));
            para.Add(new SqlParameter("@flag", "INSERT"));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            //ComFunc.excNonQuery("insert_appointments", para.ToArray(), CommandType.StoredProcedure);
            ComFunc.excNonQuery("sp_appointments", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);

        } /*InsertClient method end*/
        #endregion

        public int UpdateClient(EditProfileVM profileObj)
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
            //para.Add(new SqlParameter("@Zipcode", profileObj.Zipcode));
            //para.Add(new SqlParameter("@Phone_Countrycd", profileObj.Phone_Countrycd));
            para.Add(new SqlParameter("@Phone_STDcd", profileObj.Phone_STDcd));
            para.Add(new SqlParameter("@Phone_No", profileObj.Phone_No));
            //para.Add(new SqlParameter("@Mobile_CountryCd", profileObj.Mobile_CountryCd));
            para.Add(new SqlParameter("@Mobile_No", profileObj.Mobile_No));
            para.Add(new SqlParameter("@EmailID1", profileObj.LoginName));
            para.Add(new SqlParameter("@all_emailid", profileObj.LoginName));
            para.Add(new SqlParameter("@Website", profileObj.Website));
            para.Add(new SqlParameter("@BusinessType", profileObj.BusinessType));
            para.Add(new SqlParameter("@UpdatedBy", profileObj.ClientCd));
            para.Add(new SqlParameter("@SKYPEID", profileObj.skypeid));
            para.Add(new SqlParameter("@ISADMIN", false));

            SqlParameter retParam = new SqlParameter("@ReturnVal", 0);
            retParam.Direction = ParameterDirection.Output;

            para.Add(retParam);

            ComFunc.excNonQuery("update_ClientMaster", para.ToArray(), CommandType.StoredProcedure);

            return Convert.ToInt32(retParam.Value);

        } /*InsertClient method end*/
    } /*ClientMaster class end*/
}