alter table clientmaster add UTypeID int default 0,UserRights varchar;

update clientmaster set utypeid=0;

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

alter PROCEDURE [dbo].[Insert_ClientMaster]    
@ReturnVal int output,    
@LoginName varchar(100) ,    
@Password varchar(100) ,    
@Title varchar(5) ,    
@FirstName varchar(50) ,    
@LastName varchar(50) ,    
@birthdate datetime =null,    
@CompanyNm varchar(250)=null ,    
@Designation varchar(100) =null,    
@ReferenceThrough varchar(150)=null ,    
@Address varchar(250) =null,    
@City varchar(50) =null,    
@State varchar(50) =null,    
@Zipcode varchar(10) =null,    
@Countrycd varchar(20) =null,    
@Phone_Countrycd varchar(10) =null,    
@Phone_STDcd varchar(10) =null,    
@Phone_No varchar(100) =null,    
@Phone_Countrycd2 varchar(10)=null ,    
@Phone_STDCd2 varchar(10)=null ,    
@Phone_No2 varchar(100) =null,    
@Fax_Countrycd varchar(10) =null,    
@Fax_STDCd varchar(10) =null,    
@Fax_No varchar(20) =null,    
@Mobile_CountryCd varchar(10)=null ,    
@Mobile_No varchar(100) =null,    
@EmailID1 varchar(75) =null,    
@EmailID2 varchar(75) =null,    
@EmailID3 varchar(75) =null,    
@all_emailid varchar(300)=null,    
@Website varchar(100) =null,    
@BusinessType varchar(150)=null ,    
@CreatedBy numeric(10)=null,    
@status varchar(10)=null,    
@bankdetails varchar(4000)=null,    
@routingdetails varchar(4000)=null,    
@SkypeId varchar(100)=null,    
@QQId varchar(100) =null,  
@utypeid int =0
AS     
BEGIN    
Declare @SavedOn datetime    
SET @SavedOn = GetDate()    
  SELECT CLIENTCD FROM CLIENTMASTER WHERE loginname = @loginname
 IF @@RowCount >= 1     
  BEGIN    
   --SET @ReturnVal = 2    
   SET @ReturnVal = 1    
  END    
 ELSE    
  BEGIN    
	 
   INSERT INTO clientmaster(LoginName,Password,Title,FirstName,LastName,    
	   birthdate,CompanyNm,Designation,    
	   ReferenceThrough,Address,City,State,Zipcode,Countrycd,Phone_Countrycd,    
	   Phone_STDcd,Phone_No,Phone_Countrycd2,Phone_STDCd2,Phone_No2,Fax_Countrycd,    
	   Fax_STDCd,Fax_No,Mobile_CountryCd,Mobile_No,EmailID1,EmailID2,EmailID3,all_emailid,    
		 Website,BusinessType,CreatedOn,CreatedBy,status,    
		 bankdetails,routingdetails,skypeid,qqid,utypeid)     
   values(@LoginName,@Password,@Title,@FirstName,@LastName,    
	   @birthdate,@CompanyNm,@Designation,    
	   @ReferenceThrough,@Address,@City,@State,@Zipcode,@Countrycd,@Phone_Countrycd,    
	   @Phone_STDcd,@Phone_No,@Phone_Countrycd2,@Phone_STDCd2,@Phone_No2,@Fax_Countrycd,    
	   @Fax_STDCd,@Fax_No,@Mobile_CountryCd,@Mobile_No,@EmailID1,@EmailID2,@EmailID3,@all_emailid,    
		 @Website,@BusinessType,@savedon,@CreatedBy,@status,    
		 @bankdetails,@routingdetails,@SkypeId,@QQId,@utypeid)    
	  
   IF @@error <> 0 goto Err_Handler    
	   
   SET @ReturnVal = 0    
   return;
	   
   Err_Handler:    
	SET @ReturnVal = -1       
	return;
	   
   CleanUp:    
	SET @ReturnVal = 0    
	return;
  END    
		 
END 

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

alter PROCEDURE [dbo].[update_ClientMaster]  
@ReturnVal int output,  
@clientcd numeric(10),  
@Title varchar(5) ,  
@FirstName varchar(50) ,  
@LastName varchar(50) ,  
@birthdate datetime ,  
@CompanyNm varchar(250) ,  
@Designation varchar(100)= null ,  
@Terms varchar(50) = null,  
@creditdays numeric(5) = null,  
@Commission numeric(5,2) = null,  
@Brokerage numeric(5,2) = null,  
@PriceDiscount numeric(5,2) = null,  
@Discount numeric(5,2) = null,  
@PriceFormat char(10) = null,  
@TaxDetails varchar(250) = null,  
@ReferenceFrom varchar(150) = null,  
@ReferenceThrough varchar(150)= null,  
@Address varchar(250) = null,  
@City varchar(50) ,  
@State varchar(50) ,  
@Zipcode varchar(10) = null ,  
@Countrycd varchar(20) = null ,  
@Phone_Countrycd varchar(10) = null ,  
@Phone_STDcd varchar(10) = null ,  
@Phone_No varchar(100) = null ,  
@Phone_Countrycd2 varchar(10) = null,  
@Phone_STDCd2 varchar(10) = null,  
@Phone_No2 varchar(100) = null,  
@Fax_Countrycd varchar(10) = null,  
@Fax_STDCd varchar(10) = null,  
@Fax_No varchar(20) = null,  
@Mobile_CountryCd varchar(10) = null,  
@Mobile_No varchar(100) ,  
@EmailID1 varchar(75) ,  
@EmailID2 varchar(75) = null,  
@EmailID3 varchar(75) = null,  
@all_emailid varchar(300),  
@Website varchar(100) = null ,  
@BusinessType varchar(150)= null,  
@UpdatedBy numeric(10),  
@WholeStockAccess varchar(1) = null,  
@bankdetails varchar(4000) = null,  
@routingdetails varchar(4000) = null,  
@handle_location int = null,  
@smid int = null,  
@SkypeId varchar(100)=null,    
@emailstatus varchar(10)= null,
@status char=null,
@utypeid int=null,
@isAdmin bit
AS   
BEGIN  
	Declare @SavedOn datetime  
	SET @SavedOn = GetDate()  

	IF @ISADMIN = 0 BEGIN
	  update clientmaster set   
		Title=@Title,FirstName=@FirstName,LastName=@LastName,  
		birthdate=@birthdate,CompanyNm=@CompanyNm,Designation=@Designation,Terms=@Terms,creditdays=@creditdays,  
		Commission=@Commission,Brokerage=@Brokerage,PriceDiscount=@PriceDiscount,Discount=@Discount,PriceFormat=@PriceFormat,  
		TaxDetails=@TaxDetails,ReferenceFrom=@ReferenceFrom,ReferenceThrough=@ReferenceThrough,  
		Address=@Address,City=@City,State=@State,Zipcode=@Zipcode,Countrycd=@Countrycd,  
		Phone_Countrycd=@Phone_Countrycd,Phone_STDcd=@Phone_STDcd,Phone_No=@Phone_No,Phone_Countrycd2=@Phone_Countrycd2,  
		Phone_STDCd2=@Phone_STDCd2,Phone_No2=@Phone_No2,Fax_Countrycd=@Fax_Countrycd,Fax_STDCd=@Fax_STDCd,  
		Fax_No=@Fax_No,Mobile_CountryCd=@Mobile_CountryCd,Mobile_No=@Mobile_No,EmailID1=@EmailID1,EmailID2=@EmailID2,  
		EmailID3=@EmailID3,all_emailid=@all_emailid,Website=@Website,BusinessType=@BusinessType,UpdatedOn=@SavedOn,UpdatedBy=@UpdatedBy,  
		WholeStockAccess=@WholeStockAccess, SKYPEID = @SKYPEID,status=@status,
		bankdetails=@bankdetails,routingdetails=@routingdetails,handle_location=@handle_location,smid=@smid,emailstatus=@emailstatus
		where clientcd=@clientcd  
		
		SET @ReturnVal = 0  return;
	END
	ELSE IF @ISADMIN = 1 BEGIN
		update clientmaster set   
			Title=@Title,FirstName=@FirstName,LastName=@LastName,  
			birthdate=@birthdate,CompanyNm=@CompanyNm,Designation=@Designation,ReferenceThrough=@ReferenceThrough,  
			Address=@Address,City=@City,State=@State,Zipcode=@Zipcode,Countrycd=@Countrycd,  
			Phone_Countrycd=@Phone_Countrycd,Phone_STDcd=@Phone_STDcd,Phone_No=@Phone_No,Mobile_CountryCd=@Mobile_CountryCd,
			Mobile_No=@Mobile_No,EmailID1=@EmailID1,all_emailid=@all_emailid,Website=@Website,BusinessType=@BusinessType,
			SKYPEID = @SKYPEID,UpdatedOn=@SavedOn,UpdatedBy=@UpdatedBy,status=@status, utypeid= @utypeid
		where clientcd=@clientcd  
		
		SET @ReturnVal = 0  return;
	END 

	IF @@error <> 0 goto Err_Handler  

	Err_Handler:  
	SET @ReturnVal = -1   return;

	CleanUp:  SET @ReturnVal = 0  RETURN;
  
END
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

create function [dbo].isSeller(@pLoginName nvarchar(60)) returns char
as
begin
declare @retval char,@pCount int;
	set @retval='N';
	select @pCount=count(1) from usermas where lower(emailid)=lower(@ploginname)
	and utypeid =(select utypeid from usertypemaster where usertype='sm');
	if @pCount>0 
	begin
		set @retval='Y';
	end
	return @retval;
end

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create procedure sp_isClientValid
@Username varchar(60),
@password varchar(50)
as
begin
	IF  EXISTS(SELECT LOGINNAME FROM CLIENTMASTER WHERE LOGINNAME=@USERNAME and password=@password) BEGIN
		SELECT PASSWORD,CLIENTCD,EMAILID1,TITLE + ' ' + FIRSTNAME + ' ' + LASTNAME CLIENTNAME, FIRSTNAME, STATUS,
		ISNULL(ADDRESS,'') + ',' + ISNULL(CITY,'') + ',' + ISNULL(STATE,'') + ',' + ISNULL(ZIPCODE,'') + ',' + ISNULL(DBO.GETPROCNM(COUNTRYCD,'COUNTRY'),'') AS CLIENTFULLADDRESS 
		,DBO.ISSELLER(@Username) ISSELLER, handle_location 
		,UTYPEID 
		FROM CLIENTMASTER 

		WHERE LOGINNAME=@Username AND PASSWORD =@password COLLATE SQL_LATIN1_GENERAL_CP1_CS_AS
	end;
end

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create function GetClientPassword(@EmailId varchar(60)) returns varchar(30)
as
begin
	declare @password varchar(30);
	select @password=password from clientmaster where loginname = @Emailid;
	return @password;
end;

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
alter function GetHandleLocationByLoginName(@LoginName varchar(60),@Handle_Location varchar(30)) returns nvarchar(max) as  
begin  
 declare @CompanyAddress nvarchar(max);  
 declare @HandleLocation VARCHAR(30);
 if exists(select loginname from clientmaster where loginname=@LoginName) begin  
  select @CompanyAddress = a.address from companydet a, procmas b, clientmaster c  
  where a.type=b.procnm and b.proccd = c.handle_location and c.loginname = @LoginName;  
  
  if @Handle_Location='' begin
	set @Handle_Location=2;
  end;
  
  select @HandleLocation = procnm from procmas where procgroup='LOCATION' AND PROCCD=@Handle_Location
  
 end;  

 if @CompanyAddress = '' or @CompanyAddress is null begin  
  if @Handle_Location <>'' begin  
   select @CompanyAddress = address from companydet where type=@HandleLocation
   end;  
  else begin  
   select @CompanyAddress = address from companydet where type='mumbai'  
   end;  
 end;  
   
 return @CompanyAddress;  
end;
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE PROCEDURE [dbo].[ClientChangePassword]
@ReturnVal int output,
@LoginName varchar(60),
@OldPassword varchar(100),
@NewPassword varchar(100)
AS
begin
Declare @UpdatedOn datetime  
SET @UpdatedOn = GetDate()    
	IF exists(SELECT loginname FROM clientmaster WHERE loginname =@LoginName and Password = @OldPassword ) BEGIN  
	 UPDATE clientmaster SET Password = @NewPassword,updatedon =@UpdatedOn WHERE LoginName= @LoginName
		SET @ReturnVal = 0
		END  
	ELSE BEGIN  
		SET @ReturnVal = 1  
	END
end;

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER PROCEDURE [dbo].[spInsertShoppingCart]
@ReturnVal VARCHAR(MAX) OUTPUT,
@SC_stoneidS varchar(MAX),
@SC_clientcd int,
@SC_Status varchar(50),
@sc_offerrate numeric(15,2),
@sc_offerdisc numeric(5,2)
AS
BEGIN
	SET NOCOUNT ON;
		
	/*------------------------------------------------SHOPPINGCART INSERTION PROCESS BY CSV FROMATTED STONE VALUES*/
	DECLARE @SC_Date datetime, @ISHOLDBYREQUEST int, @SC_MemoDate datetime, @SC_delete_Date datetime;
	DECLARE @VSTONEID VARCHAR(30),@DELIMITER CHAR,@DELIMINDEX INT, @VSTONEIDLIST VARCHAR(MAX);
	SET @VSTONEIDLIST= @SC_stoneidS + ',';
	SET @Delimiter=','	
	SET @DelimIndex = CHARINDEX(@Delimiter, @VSTONEIDLIST, 0)
	SET @SC_Date = GetDate();
	SET @SC_MemoDate = GetDate();
		
	WHILE (@DelimIndex != 0) BEGIN
	
		SET @VSTONEID = SUBSTRING(@VSTONEIDLIST, 0, @DelimIndex)
		
		BEGIN
			IF @SC_Status='I' BEGIN
				SELECT @SC_delete_Date =  getdate() + sc_delete_days  FROM SETTINGS
				END 
			ELSE IF @SC_Status='B' OR @SC_Status='BID'  BEGIN
				SELECT @SC_delete_Date =  getdate() + scbr_delete_days  FROM SETTINGS
			END;

			select @ISHOLDBYREQUEST = count(1) from ShoppingCart WHERE SC_stoneid=@VSTONEID and (sc_status='H' OR   sc_status='B')
			IF @ISHOLDBYREQUEST > 0 BEGIN    
				goto BuyRequest        
			END;       
		END;
		
		IF @VSTONEID<>'' BEGIN
		
			IF NOT EXISTS (SELECT SC_Id FROM ShoppingCart WHERE SC_clientcd=@SC_clientcd AND SC_stoneid=@VSTONEID ) BEGIN
				IF @SC_Status='I' BEGIN        
					INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd, SC_Status, SC_Date, SC_delete_Date, sc_offerrate, sc_offerdisc)        
						VALUES(@VSTONEID, @SC_clientcd, @SC_Status, @SC_Date, @SC_delete_Date, @sc_offerrate, @sc_offerdisc)
				END
			
				ELSE IF @SC_Status='B' BEGIN
					INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd, SC_Status, SC_Date, SC_delete_Date, sc_offerrate, sc_offerdisc)
						VALUES(@VSTONEID, @SC_clientcd, @SC_Status, @SC_Date, @SC_delete_Date, @sc_offerrate, @sc_offerdisc)
				END        
				
				ELSE IF @SC_Status='BID' BEGIN
					INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd, SC_Status, SC_Date, SC_delete_Date, sc_offerrate, sc_offerdisc)        
						VALUES(@VSTONEID, @SC_clientcd, 'B', @SC_Date, @SC_delete_Date, @sc_offerrate, @sc_offerdisc)
				END        
				
				ELSE IF @SC_Status='M' BEGIN
					INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd, SC_Status, SC_Date, SC_MemoDate, SC_delete_Date, sc_offerrate, sc_offerdisc)        
						VALUES(@VSTONEID, @SC_clientcd, @SC_Status, @SC_Date, @SC_MemoDate, @SC_delete_Date, @sc_offerrate, @sc_offerdisc)        
				END         
			
				ELSE BEGIN
					UPDATE ShoppingCart SET SC_MemoDate=@SC_MemoDate, SC_Status=@SC_Status, sc_offerrate=@sc_offerrate, sc_offerdisc=@sc_offerdisc
						WHERE SC_stoneid=@VSTONEID AND SC_clientcd=@SC_clientcd        
				END
			END
			ELSE BEGIN                          
				UPDATE ShoppingCart SET SC_Status=@SC_Status ,                          
					sc_offerrate=@sc_offerrate,sc_offerdisc=@sc_offerdisc,SC_Date=@SC_Date,sc_delete_date=@sc_delete_date
					WHERE SC_stoneid=@VSTONEID AND SC_clientcd=@SC_clientcd
			END
			
			SET @VSTONEIDLIST  = SUBSTRING(@VSTONEIDLIST, @DelimIndex+1, LEN(@VSTONEIDLIST)-@DelimIndex);
			SET @DelimIndex = CHARINDEX(@Delimiter, @VSTONEIDLIST, 0);

		END;
	END;
	BuyRequest:  
	SET @ReturnVal = @ReturnVal + ',' + @VSTONEID;
END;

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER PROCEDURE [dbo].[insert_appointments]  
@ReturnVal int output,  
@Location varchar(10),  
@CompanyName varchar(100),  
@PersonName varchar(100),  
@emailid varchar(200),  
@contact1 varchar(100),  
@contact2 varchar(100),  
@interested varchar(4000),  
@appdate datetime,  
@totperson numeric(5),  
@remarks varchar(4000),  
@status varchar(2),  
@ftime varchar(5),  
@ttime varchar(5)  
AS   
BEGIN  
	Declare @SavedOn datetime
	SET @SavedOn = GetDate()    
	
	BEGIN  
		INSERT INTO appointments(Location, CurDate, CompanyName, Personname, emailid, contact1,  
			contact2, interested, appdate, totperson, remarks, status,ftime,ttime)   
		values(@Location, @SavedOn, @CompanyName,@PersonName, @emailid, @contact1,   
			@contact2, @interested, @appdate, @totperson, @remarks, @status,@ftime,@ttime)  
      
   SET @ReturnVal = 0  
   RETURN
    
   IF @@error <> 0 goto Err_Handler  
     
   Err_Handler:  
    SET @ReturnVal = -1  
	
  END
  
END

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
DROP TABLE  [dbo].[UserSearchHistory];

CREATE TABLE [dbo].[UserSearchHistory](
	[SID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SearchName] [varchar](100) NULL,
	[SAVEDON] [datetime] NULL,
	[CID] [int] NULL,
	[SHAPE] [varchar](max) NULL,
	[CTS] [varchar](20) NULL,
	[MCTS] [varchar](MAX) NULL,
	[COLOR] [varchar](50) NULL,
	[MCOLOR] [varchar](MAX) NULL,
	[CLARITY] [varchar](50) NULL,
	[MCLARITY] [varchar](MAX) NULL,
	[CUT] [varchar](60) NULL,
	[MCUT] [varchar](max) NULL,
	[POLISH] [varchar](50) NULL,
	[MPOLISH] [varchar](MAX) NULL,
	[SYM] [varchar](50) NULL,
	[MSYM] [varchar](MAX) NULL,
	[FL] [varchar](50) NULL,
	[MFL] [varchar](MAX) NULL,
	[CERTIFICATE] [varchar](MAX) NULL,
	[CERTNO] [varchar](MAX) NULL,
	[RATE] [varchar](60) NULL,
	[DISCPER] [varchar](60) NULL,
	[AMT] [varchar](60) NULL,
	[RAPARATE] [varchar](60) NULL,
	[RAPAAMT] [varchar](60) NULL,
	[INCLUSION] [varchar](MAX) NULL,
	[STONEID] [varchar](MAX) NULL,
	[TABLEPER] [varchar](60) NULL,
	[DEPTHPER] [varchar](60) NULL,
	[GIRDLEPER] [varchar](60) NULL,
	[lengthmm] [varchar](100) NULL,
	[widthmm] [varchar](100) NULL,
	[depthmm] [varchar](100) NULL,
	[location] [varchar](100) NULL,
	[flcolor] [varchar](100) NULL,
	[culet] [varchar](100) NULL,
	[ratiomm] [varchar](100) NULL,
	[SHOWONLY] [varchar](12) NULL,
	[ORD1] [varchar](200) NULL,
	[ORD2] [varchar](200) NULL,
	[ORD3] [varchar](200) NULL,
	[ORD4] [varchar](200) NULL,
	[ORD5] [varchar](200) NULL,
	[ORD6] [varchar](200) NULL,
	[PAGESIZE] [varchar](20) NULL,
	[AUTO] [varchar](1) NULL,
	[usertype] [varchar](30) NULL,
	[uid] [numeric](10, 0) NULL,
	[isFancy] [char](1) NULL
) ON [PRIMARY]

GO
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
CREATE PROCEDURE INSERT_USERSEARCHHISTORY 
@SearchName	varchar(60),
@CID	int,
@SHAPE	varchar(MAX)= null,
@CTS	varchar(20)= null,
@MCTS	varchar(MAX)= null,
@COLOR	varchar(50)= null,
@MCOLOR	varchar(MAX)= null,
@CLARITY	varchar(50)= null,
@MCLARITY	varchar(MAX)= null,
@CUT	varchar(60)= null,
@MCUT	varchar(MAX)= null,
@POLISH	varchar(50)= null,
@MPOLISH	varchar(MAX)= null,
@SYM	varchar(50)= null,
@MSYM	varchar(MAX)= null,
@FL	varchar(50)= null,
@MFL	varchar(MAX)= null,
@CERTIFICATE	varchar(MAX)= null,
@CERTNO	varchar(MAX)= null,
@RATE	varchar(20)= null,
@DISCPER	varchar(20)= null,
@AMT	varchar(20)= null,
@RAPARATE	varchar(20)= null,
@RAPAAMT	varchar(20)= null,
@INCLUSION	varchar(MAX)= null,
@STONEID	varchar(MAX)= null,
@TABLEPER	varchar(30)= null,
@DEPTHPER	varchar(30)= null,
@GIRDLEPER	varchar(30)= null,
@lengthmm	varchar(30)= null,
@widthmm	varchar(30)= null,
@depthmm	varchar(30)= null,
@location	varchar(30)= null,
@flcolor	varchar(MAX)= null,
@culet	varchar(MAX)= null,
@ratiomm	varchar(30)= null,
@SHOWONLY	varchar(20)= null,
@ORD1	varchar(30)= null,
@ORD2	varchar(30)= null,
@ORD3	varchar(30)= null,
@ORD4	varchar(30)= null,
@ORD5	varchar(30)= null,
@ORD6	varchar(30)= null,
@PAGESIZE	varchar(30)= null,
@AUTO	varchar(20)= null,
@usertype	varchar(30)= null,
@uid	int= null,
@isFancy	char= null,
@ReturnVal int output,
@sid int output
AS
BEGIN
	SELECT SID FROM SearchHistory WHERE CID = @CID  
  
	IF @@RowCount >= 10000000  BEGIN  
		SET @ReturnVal = 1  
	END  
	ELSE BEGIN
		INSERT INTO USERSearchHistory(SearchName,SAVEDON, CID, SHAPE, CTS, MCTS, COLOR, MCOLOR, CLARITY, MCLARITY, CUT, MCUT, POLISH, MPOLISH, SYM, MSYM, 
							FL, MFL, CERTIFICATE, CERTNO, RATE, DISCPER, AMT, RAPARATE, RAPAAMT, INCLUSION, STONEID, TABLEPER, DEPTHPER, GIRDLEPER, 
							lengthmm, widthmm, depthmm, location, flcolor, culet, ratiomm, SHOWONLY, 
							ORD1, ORD2, ORD3, ORD4, ORD5, ORD6, PAGESIZE, AUTO, usertype, uid, isFancy)
		   values(@SearchName, GETDATE(), @CID, @SHAPE, @CTS, @MCTS, @COLOR, @MCOLOR, @CLARITY, @MCLARITY, @CUT, @MCUT, @POLISH, @MPOLISH, @SYM, @MSYM, 
							@FL, @MFL, @CERTIFICATE, @CERTNO, @RATE, @DISCPER, @AMT, @RAPARATE, @RAPAAMT, @INCLUSION, @STONEID, @TABLEPER, @DEPTHPER, 
							@GIRDLEPER, @lengthmm, @widthmm, @depthmm, @location, @flcolor, @culet, @ratiomm, @SHOWONLY, 
							@ORD1, @ORD2, @ORD3, @ORD4, @ORD5, @ORD6, @PAGESIZE, @AUTO, @usertype, @uid, @isFancy)  

			SET @SID= SCOPE_IDENTITY();   
			SET @ReturnVal = 0  
	END;
	
	IF @@error <> 0 SET @ReturnVal = -1
END;
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE VIEW VIEW_NEW_GRADDET AS
SELECT STONEID, CTS, GD.SHAPE SHAPE, GD.COLOR AS COLOR, COLORDESC, GD.CLARITY AS CLARITY, GD.CUT AS CUT, GD.POLISH AS POLISH, 
GD.SYM AS SYM, FLSHORTNM, FLOURENCE, CERTIFICATE, CERTNO, LENGTH, WIDTH, HEIGHT, DEPTH, DIATABLE, LUSTER, GD.GIRDLE AS GIRDLE, 
GD.CULET AS CULET, CROWN, CROWNANGLE, CROWNHEIGHT, PAVILION, PAVANGLE, PAVHEIGHT, MILKY, SHADE,HA, INCLUSION,NATTS, NATURAL, PAIR, 
ASKRATE_FC, ISNULL(ASKDISC_FC, 0) ASKDISC_FC, ISNULL(ASKAMT_FC, 0) ASKAMT_FC, 
ISNULL(COSTRATE_FC,0)COSTRATE_FC, ISNULL(COSTDISC_FC,0)COSTDISC_FC, ISNULL(COSTAMT_FC,0)COSTAMT_FC,
ISNULL(RAPARATE, 0) RAPARATE, ROUND(isnull(RAPARATE,0) * CTS, 2) RAPAAMT, 
ISNULL(ORDSHAPE,999) ORDSHAPE, ISNULL(ORDCOLOR,999) ORDCOLOR, ISNULL(ORDCLARITY,999) ORDCLARITY, ISNULL(ORDCUT,999) ORDCUT,
ISNULL(ORDPOLISH,999) ORDPOLISH, ISNULL(ORDSYM,999) ORDSYM, ISNULL(ORDFL,999) ORDFL, ISNULL(ORDGIRDLE,999) ORDGIRDLE, ISNULL(ORDCULET,999) ORDCULET,
CURDATE, '[' + dbo.getnewarrivalstatus(curdate) + ']' + '[' + isnull(LEGEND2, '-') + ']' + '[' + isnull(LEGEND3, '-') + ']' STATUS, 
LOCATION, MEASUREMENT,  GD.fl_color AS fl_color, fl_coL_shortnm, 
dbo.getnewarrivalstatus(curdate) legend1, isnull(LEGEND2, '-') legend2, isnull(LEGEND3, '-') legend3, 
GIRDLE_CONDITION, RATIO, STAR_LENGTH, LOWER_HALF, KEY_TO_SYMBOL, REPORT_COMMENT, dbo.get_rapa_size(cts) RapSize, GIRDLEPER, DIA, BARCODE, 
INSCRIPTION, dbo.GET_FANCY_COLOR_STATUS(GD.COLOR) FANCY_COLOR_STATUS, NEW_CERT 
FROM dbo.GRADDET GD
LEFT JOIN (SELECT PROCNM AS SHAPE,ORD AS ORDSHAPE FROM PROCMAS WHERE PROCGROUP='SHAPE' AND STATUS='Y') SHAPEMAS
ON GD.SHAPE = SHAPEMAS.SHAPE
LEFT JOIN (SELECT PROCNM AS COLOR,ORD AS ORDCOLOR FROM PROCMAS WHERE PROCGROUP='COLOR' AND STATUS='Y') COLORMAS
ON GD.COLOR = COLORMAS.COLOR
LEFT JOIN (SELECT PROCNM AS CLARITY,ORD AS ORDCLARITY FROM PROCMAS WHERE PROCGROUP='CLARITY' AND STATUS='Y') CLARITYMAS
ON GD.CLARITY = CLARITYMAS.CLARITY
LEFT JOIN (SELECT PROCNM AS CUT,ORD AS ORDCUT FROM PROCMAS WHERE PROCGROUP='CUT' AND STATUS='Y') CUTMAS
ON GD.CUT= CUTMAS.CUT
LEFT JOIN (SELECT PROCNM AS POLISH,ORD AS ORDPOLISH FROM PROCMAS WHERE PROCGROUP='POLISH' AND STATUS='Y') POLISHMAS
ON GD.POLISH = POLISHMAS.POLISH
LEFT JOIN (SELECT PROCNM AS SYM,ORD AS ORDSYM FROM PROCMAS WHERE PROCGROUP='SYM' AND STATUS='Y') SYMMAS
ON GD.SYM = SYMMAS.SYM
LEFT JOIN (SELECT PROCNM AS FL,SHORTNM AS FLSHORTNM, ORD AS ORDFL FROM PROCMAS WHERE PROCGROUP='FLOURENCE' AND STATUS='Y') FLMAS
ON GD.FLOURENCE = FLMAS.FL
LEFT JOIN (SELECT PROCNM AS FL_COLOR,SHORTNM AS FL_COL_SHORTNM, ORD AS ORDFL_COLOR FROM PROCMAS WHERE PROCGROUP='FL_COLOR' AND STATUS='Y') FL_COLORMAS
ON GD.FL_COLOR = FL_COLORMAS.FL_COLOR
LEFT JOIN (SELECT PROCNM AS GIRDLE,ORD AS ORDGIRDLE FROM PROCMAS WHERE PROCGROUP='GIRDLE' AND STATUS='Y') GIRDLEMAS
ON GD.GIRDLE = GIRDLEMAS.GIRDLE
LEFT JOIN (SELECT PROCNM AS CULET,ORD AS ORDCULET FROM PROCMAS WHERE PROCGROUP='CULET' AND STATUS='Y') CULETMAS
ON GD.CULET = CULETMAS.CULET

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER TABLE CLIENTLOGINHISTORY 
ADD TRACKED_IP VARCHAR(30)

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE VIEW VIEW_CLIENTDET AS
SELECT CM.CLIENTCD AS CLIENTCD,CM.LOGINNAME AS LOGINNAME,DBO.INITCAP(TITLE) + ' ' + DBO.INITCAP(FIRSTNAME) + ' ' + DBO.INITCAP(LASTNAME) CLIENTNAME,
PASSWORD, COMPANYNM, DESIGNATION, CITY, DBO.GETPROCNM(COUNTRYCD,'COUNTRY')COUNTRY, EMAILID1, WEBSITE, STATUS,LASTLOGGEDON,TRACKED_IP,
DBO.GETPROCVALBYTYPE(STATUS,'CLIENTSTATUS','PROCNM','SHORTNM')AS STATUSDESC, PHONE_COUNTRYCD + ' ' + PHONE_STDCD + ' ' +PHONE_NO AS CONTACTNO,
'NONE' AS APPOINTMENTREQUEST, MAILTYPE, LOCATION, SALESMAN, BR_CNT, SC_CNT, WL_CNT,UTYPEID
FROM CLIENTMASTER CM
LEFT JOIN (SELECT PROCNM AS MAILTYPE,SHORTNM,ORD FROM PROCMAS WHERE PROCGROUP = 'EMAILSTATUS') AS ES ON ES.ORD = CM.EMAILSTATUS
LEFT JOIN (SELECT PROCNM AS LOCATION,SHORTNM,ORD FROM PROCMAS WHERE PROCGROUP = 'LOCATION') AS LOC ON LOC.ORD = CM.COUNTRYCD
LEFT JOIN (SELECT CLIENTCD,LOGINNAME AS SALESMAN FROM CLIENTMASTER WHERE UTYPEID <> 0 ) AS SM ON SM.CLIENTCD = CM.CLIENTCD
LEFT JOIN (SELECT COUNT(1) AS BR_CNT,SC_CLIENTCD FROM SHOPPINGCART WHERE SC_STATUS='B' AND (SC_DELETE_DATE > GETDATE() OR SC_DELETE_DATE IS NULL) AND SC_STONEID IN (SELECT STONEID FROM GRADDET) GROUP BY SC_CLIENTCD) AS BR ON BR.SC_CLIENTCD= CM.CLIENTCD
LEFT JOIN (SELECT SC_CLIENTCD,COUNT(1) AS SC_CNT FROM SHOPPINGCART WHERE SC_STATUS='I' AND (SC_DELETE_DATE > GETDATE() OR SC_DELETE_DATE IS NULL) AND SC_STONEID IN (SELECT STONEID FROM GRADDET) GROUP BY SC_CLIENTCD)AS SC ON SC.SC_CLIENTCD= CM.CLIENTCD
LEFT JOIN (SELECT CLIENTCD,COUNT(1) AS WL_CNT FROM MYWATCHLIST WHERE STATUS='Y' GROUP BY CLIENTCD) AS WL ON WL.CLIENTCD = CM.CLIENTCD
LEFT JOIN (SELECT CLIENTCD, MAX(CLOGINTIME) LASTLOGGEDON, MAX(TRACKED_IP) TRACKED_IP FROM CLIENTLOGINHISTORY GROUP BY CLIENTCD) AS LH ON LH.CLIENTCD= CM.CLIENTCD

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER PROC [dbo].[SP_CLIENTLOGINHISTORY]
@CLIENTCD int,
@CSessionID varchar(75),
@TRACK_IP VARCHAR(30),
@CAction char(1),
@CLogID int,
@ReturnVal INT OUTPUT
As 
BEGIN  
	DECLARE @CLoginTime DATETIME;	SET @CLoginTime =GETDATE();
	SET NOCOUNT ON  
	IF @CAction = 'I' BEGIN   
		UPDATE ClientLoginHistory  SET CLogout = 'Y'  WHERE  clientcd = @clientcd
		
		INSERT INTO ClientLoginHistory (CLIENTCD, CLoginTime,CLogout, CSessionID,TRACKED_IP)  
		VALUES (@CLIENTCD, @CLoginTime,'N', @CSessionID,@TRACK_IP)  
   
		UPDATE clientmaster set lastlogindate=@CLoginTime where clientcd = @clientcd  
		SET @ReturnVal = @@Identity
		RETURN
	END  
	ELSE IF @CAction = 'U' BEGIN     
		UPDATE ClientLoginHistory  SET CLogout = 'Y', CLogoutTime = GETDATE()
			WHERE clientcd = @clientcd AND CSessionID = @CSessionID AND LogID = @CLogID  
	
		SET @ReturnVal = 0  
		RETURN
	END  
  
	SET NOCOUNT OFF  
END  

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

insert into procmas (procgroup,proccd,procnm,shortnm,ord,status)
values ('USERTYPE',0,'NORMAL','Normal',1,'Y');

insert into procmas (procgroup,proccd,procnm,shortnm,ord,status)
values ('USERTYPE',1,'SUPER ADMIN','Super Admin',2,'Y');

insert into procmas (procgroup,proccd,procnm,shortnm,ord,status)
values ('USERTYPE',2,'LOCATION ADMIN','Location Admin',3,'Y');

insert into procmas (procgroup,proccd,procnm,shortnm,ord,status)
values ('USERTYPE',3,'SALES MANAGER','Sales Manager',4,'Y');

insert into procmas (procgroup,proccd,procnm,shortnm,ord,status)
values ('USERTYPE',4,'REFEREE','Referee',5,'Y');

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE PROCEDURE [dbo].[spPROCMas_Event]      
@ReturnVal int output,      
@PPROCGROUP AS VARCHAR(100),      
@PPROCCD AS numeric(10),      
@ORD AS numeric(10),     
@PROCNM AS VARCHAR(100),      
@PSHORTNM AS VARCHAR(100),    
@PSTATUS AS CHAR,  
@FLAG VARCHAR(20)  
AS       
BEGIN      
 DECLARE @MAXPROCCD AS INTEGER      
 DECLARE @MAXORD AS INTEGER        
 BEGIN      
  IF @FLAG ='UPDATE' BEGIN      
   IF EXISTS(SELECT PROCCD FROM procmas WHERE procgroup=@PPROCGROUP AND proccd = @PPROCCD) BEGIN      
    UPDATE [procmas] SET [procnm] = @PROCNM ,[shortnm]  = @PSHORTNM ,[ORD] = @ORD, [STATUS] = @PSTATUS  
     WHERE procgroup=@PPROCGROUP AND proccd = @PPROCCD      
      
    SET @ReturnVal = 1  
    RETURN  
   END       
  END         
  ELSE IF @FLAG ='INSERT' BEGIN      
   SELECT @MAXPROCCD=MAX(PROCCD)+1,@MAXORD=MAX(ORD)+1 FROM procmas WHERE procgroup=@PPROCGROUP   
	IF @ORD <> 0 BEGIN 
		set @MAXORD=@ORD;
	END;
   INSERT INTO [procmas] ([procgroup],[proccd],[procnm],[shortnm],[ord],[status])  
    VALUES (@PPROCGROUP,@MAXPROCCD,@PROCNM,@PSHORTNM,@MAXORD,'Y')  
      
   SET @ReturnVal = 0  
   RETURN  
  END      
  ELSE IF @FLAG ='DELETE' BEGIN      
   DELETE FROM PROCMAS WHERE PROCGROUP=@PPROCGROUP AND PROCCD=@PPROCCD AND PROCNM=@PROCNM  
      
   SET @ReturnVal = 2  
   RETURN  
  END      
    
  IF @@error <> 0  
   SET @ReturnVal = -1  
   RETURN  
 END      
 SET @ReturnVal =-1  
 RETURN  
END  

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

alter table procmas 
add isChangeable bit not null
constraint df_procmas_changeable default 1 ;

UPDATE PROCMAS SET ISCHANGEABLE=0 WHERE STATUS='N' AND PROCGROUP IN('CLARITY','COLOR','EMAILSTATUS','USER_LEVEL','USERTYPE','CLIENTSTATUS');

UPDATE PROCMAS SET ISCHANGEABLE=0 WHERE STATUS='Y' AND PROCGROUP IN('EMAILSTATUS','USER_LEVEL','USERTYPE','CLIENTSTATUS');
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE PROCEDURE [dbo].[spColorMas_Event]      
@ReturnVal int output,      
@PPROCCD AS numeric(10),      
@ORD AS numeric(10),     
@PROCNM AS VARCHAR(100),      
@PSHORTNM AS VARCHAR(100),    
@PSTATUS AS CHAR,  
@PISFANCY AS CHAR,      
@FLAG VARCHAR(20)  
AS       
BEGIN      
 DECLARE @MAXPROCCD AS INTEGER      
 DECLARE @MAXORD AS INTEGER        
 BEGIN      
  IF @FLAG ='UPDATE' BEGIN      
   IF EXISTS(SELECT PROCCD FROM procmas WHERE procgroup='COLOR' AND proccd = @PPROCCD) BEGIN      
    UPDATE [procmas] SET [procnm] = @PROCNM ,[shortnm]  = @PSHORTNM ,[ORD] = @ORD, [STATUS] = @PSTATUS  , [FANCY_COLOR_STATUS] = @PISFANCY
     WHERE procgroup='COLOR' AND proccd = @PPROCCD      
      
    SET @ReturnVal = 1  
    RETURN  
   END       
  END         
  ELSE IF @FLAG ='INSERT' BEGIN      
   SELECT @MAXPROCCD=MAX(PROCCD)+1, @MAXORD=MAX(ORD)+1 FROM PROCMAS WHERE procgroup='COLOR'   
	IF @ORD <> 0 BEGIN 
		set @MAXORD=@ORD;
	END;
   INSERT INTO [procmas] ([procgroup],[proccd],[procnm],[shortnm],[ord],[status],[fancy_color_status])  
    VALUES ('COLOR', @MAXPROCCD, @PROCNM, @PSHORTNM, @MAXORD, 'Y', @PISFANCY)  
      
   SET @ReturnVal = 0  
   RETURN  
  END      
  ELSE IF @FLAG ='DELETE' BEGIN      
   DELETE FROM PROCMAS WHERE PROCGROUP='COLOR' AND PROCCD=@PPROCCD AND PROCNM=@PROCNM  
      
   SET @ReturnVal = 2  
   RETURN  
  END      
    
  IF @@error <> 0  
   SET @ReturnVal = -1  
   RETURN  
 END      
 SET @ReturnVal =-1  
 RETURN  
END  

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE PROCEDURE [dbo].[sp_appointments]    
@ReturnVal int output, 
@APPID INT,   
@Location varchar(10),    
@CompanyName varchar(100),    
@PersonName varchar(100),    
@emailid varchar(200),    
@contact1 varchar(100),    
@contact2 varchar(100),    
@interested varchar(4000),    
@appdate datetime,    
@totperson numeric(5),    
@remarks varchar(4000),    
@status varchar(2),    
@ftime varchar(5),    
@ttime varchar(5),
@UPDATEDBY NUMERIC(10,0)=NULL,
@FLAG VARCHAR(20)
AS     
BEGIN    
	Declare @SavedOn datetime  
	SET @SavedOn = GetDate()      
	
	IF @FLAG='INSERT' BEGIN
		INSERT INTO appointments(Location, CurDate, CompanyName, Personname, emailid, contact1,    
			contact2, interested, appdate, totperson, remarks, status,ftime,ttime)     
		values(@Location, @SavedOn, @CompanyName,@PersonName, @emailid, @contact1,     
			@contact2, @interested, @appdate, @totperson, @remarks, @status,@ftime,@ttime)
		
		SET @ReturnVal = 0
		RETURN
	END;
	IF @FLAG='UPDATE' BEGIN
		UPDATE APPOINTMENTS SET STATUS = @STATUS ,UPDATEDBY = @UPDATEDBY,STATUSUPDATEDON = GETDATE()
			WHERE APPID = @APPID
		SET @ReturnVal = 1
		RETURN
    END;
      
	IF @@error <> 0 goto Err_Handler    
       
	Err_Handler: 
	SET @ReturnVal = -1
	RETURN
END

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER TABLE COMPANYDET
ALTER COLUMN ADDRESS VARCHAR(4000);

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
drop table [dbo].[guestmaster];

/****** Object:  Table [dbo].[guestmaster]    Script Date: 08/21/2016 20:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[guestmaster](
	[GUEST_ID] INT IDENTITY(1,1),
	[FirstNm] [varchar](100) NULL,
	[LastNm] [varchar](100) NULL,
	[CompanyNm] [varchar](250) NULL,
	[EmailID] [varchar](75) NOT NULL,
	[Phone_Countrycd] [varchar](10) NULL,
	[Phone_STDcd] [varchar](10) NULL,
	[Phone_No] [varchar](20) NULL,
	[Mobile_No] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[LastLogInTime] [datetime] NULL,
	[CountLogs] [int] NULL,
	[isdeleted] [varchar](1) NULL,
 CONSTRAINT [pk_gm_emailid] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE TABLE UPLOAD_EXCEL_FORMAT
(
	UPLOAD_TYPE VARCHAR(30),
	COLUMN_NAME VARCHAR(60),
	SHOWCOLUMN_NAME VARCHAR(60),
	ISREQUIRED BIT,
	ORD NUMERIC,
	COLUMN_MAPPING VARCHAR(MAX),
	CONSTRAINT PK_UPLOADEXCEL_COLNM PRIMARY KEY(UPLOAD_TYPE,COLUMN_NAME)
);

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','STONEID','STONEID',1,1,'REFNO,STONEID,REF NO')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','SHAPE','SHAPE',1,2,'SHAPE,SHP')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CTS','WEIGHT',1,3,'CTS,SIZE,WEIGHT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','COLOR','COLOR',1,4,'COLOR,COL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CLARITY','CLARITY',1,5,'CLARITY,CLA')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CUT','CUT',1,6,'CUT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','POLISH','POLISH',1,7,'POLISH,POL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','SYM','SYM',1,8,'SYM,SYMMETRY')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','FLOURENCE','FLOUR.',1,9,'FLOURENCE,FLOUR,FL,FLOURESCENCE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','FL_COLOR','FL. COLOR',0,10,'FLOURENCE_COLOR,FLOURENCE COLOR,FLOUR_COLOR,FLOUR COLOR,FL COLOR,FL_COLOR,FL_COL,FL COL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','INCLUSION','INCLUSION',0,11,'INCLUSION,INCLU')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','HA','HA',0,12,'HA')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LUSTER','LUSTER',0,13,'LUSTER')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','GIRDLE','GIRDLE',0,14,'GIRDLE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','GIRDLE_CONDITION','GIRDLE CONDITION',0,15,'GIRDLE_CONDITION,GIRDLE_CON,GIRDLE CONDITION')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CULET','CULET',0,16,'CULET,CUL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','MILKY','MILKY',0,17,'MILKY')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','SHADE','SHADE',0,18,'SHADE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','NATTS','NATTS',0,19,'NATTS')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','NATURAL','NATURAL',0,20,'NATURAL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','DEPTH','DEPTH',0,21,'DEPTH')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','DIATABLE','DIATABLE',0,22,'TABLE%,TABLE,TABLE_PER,TABLE %,TABLE PER')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LENGTH','LENGTH',0,23,'LENGTH')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','WIDTH','WIDTH',0,24,'WIDTH')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','PAVILION','PAVILION',0,25,'PAV,PAVILION')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','PAVANGLE','PAVANGLE',0,26,'PAVANGLE,PAV ANGLE,PAV>,PAV >')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','PAVHEIGHT','PAVHEIGHT',0,27,'PAVHEIGHT,PAV HEIGHT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CROWN','CROWN',0,28,'CROWN,CROWN%,CROWN %,CROWN PER,CROWN_PER')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CROWNANGLE','CROWNANGLE',0,29,'CROWNANGLE,CROWN ANGLE,CRN>,CRN >')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CROWNHEIGHT','CROWNHEIGHT',0,30,'CROWNHEIGHT,CROWN HEIGHT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','HEIGHT','HEIGHT',0,31,'HEIGHT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','RATIO','RATIO',0,32,'RATIO')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','STAR_LENGTH','STAR LENGTH',0,33,'STAR_LENGTH,STAR LENGTH')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LOWER_HALF','LOWER HALF',0,34,'LOWER HALF,LOWER_HALF')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','KEY_TO_SYMBOL','KEY TO SYMBOL',0,35,'KEY TO SYMBOL,KEY_TO_SYMBOL')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','REPORT_COMMENT','REPORT COMMENT',0,36,'REPORT_COMMENT,REPORT COMMENT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CERTIFICATE','LAB',0,37,'CERT TYPE,CERT_TYPE,CERTIFICATE,CERT,LAB')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','CERTNO','CERTNO',0,38,'CERT NO.,CERT_NO.,CERT NO,CERT_NO,CERTIFICATE NO,CERTIFICATE_NO')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','RAPARATE','RAPARATE',0,39,'RAPARATE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','RAPAAMT','RAPAAMT',0,40,'RAPAAMT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LOCATION','LOCATION',0,41,'LOCATION')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LEGEND1','LEGEND1',0,42,'LEGEND1')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','LEGEND2','LEGEND2',0,43,'LEGEND2')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','ASKRATE_FC','ASKRATE',0,44,'ASKRATE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','ASKDISC_FC','ASKDISC',0,45,'ASKDISC')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','ASKAMT_FC','ASKAMT',0,46,'ASKAMT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','COSTRATE_FC','COSTRATE',0,47,'COSTRATE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','COSTDISC_FC','COSTDISC',0,48,'COSTDISC')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','COSTAMT_FC','COSTAMT',0,49,'COSTAMT')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','GIRDLEPER','GIRDLEPER',0,50,'GIRDLE%,GIRDLE PER,GIRDLE_PER')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','DIA','DIA',0,51,'DIA')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','COLORDESC','COLORDESC',0,52,'COLOR DESCRIPTION,COLOR DESC')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','BARCODE','BARCODE',0,53,'BARCODE')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','INSCRIPTION','INSCRIPTION',0,54,'INSCRIPTION')
insert into upload_excel_format(upload_type,column_name,showcolumn_name,isrequired,ord,column_mapping) values ('WEBSYNC','MEMBER_COMMENT','MEMBER COMMENT',0,55,'MEMBER COMMENT, MEMBERCOMMENT')

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ALTER FUNCTION [dbo].[GET_EXCEL_ERRORLIST]() RETURNS TABLE
AS
RETURN
WITH CTE AS(
SELECT RNO,
 CASE WHEN OUTSHAPE='' THEN ''ELSE '; SHAPE:' + OUTSHAPE  END +
 CASE WHEN OUTCTS='' THEN ''ELSE '; WEIGHT:' + OUTCTS END +
 CASE WHEN OUTCOLOR='' THEN ''ELSE '; COLOR:' + OUTCOLOR END +
 CASE WHEN OUTCLARITY='' THEN ''ELSE '; CLARITY:' + OUTCLARITY END +
 CASE WHEN OUTCUT='' THEN ''ELSE '; CUT:' + OUTCUT END +
 CASE WHEN OUTPOLISH='' THEN ''ELSE '; POLISH:' + OUTPOLISH END +
 CASE WHEN OUTSYM='' THEN ''ELSE '; SYM:' + OUTSYM END +
 CASE WHEN OUTFL='' THEN ''ELSE '; FLOUR.:' + OUTFL END +
 /*CASE WHEN OUTFL_COLOR='' THEN ''ELSE '; FL.COLOR:' + OUTFL_COLOR END +
 CASE WHEN OUTGIRDLE='' THEN ''ELSE '; GIRDLE:' + OUTGIRDLE END +*/
 CASE WHEN OUTCERT='' THEN ''ELSE '; LAB:' + OUTCERT END +
 /*CASE WHEN OUTLOCATION='' THEN '' ELSE '; LOCATION:' + OUTLOCATION END +
 CASE WHEN OUTGIRDLEPER ='' THEN '' ELSE '; GIRDLEPER:' + OUTGIRDLEPER END + 
 CASE WHEN OUTDEPTH ='' THEN '' ELSE '; DEPTH:' + OUTDEPTH END + 
 CASE WHEN OUTDIATABLE ='' THEN '' ELSE '; TABLE:' + OUTDIATABLE END + 
 CASE WHEN OUTLENGTH ='' THEN '' ELSE '; LENGTH:' + OUTLENGTH END + 
 CASE WHEN OUTWIDTH ='' THEN '' ELSE '; WIDTH:' + OUTWIDTH END + 
 CASE WHEN OUTHEIGHT ='' THEN '' ELSE '; HEIGHT:' + OUTHEIGHT END + 
 CASE WHEN OUTPAVILION ='' THEN '' ELSE '; PAVILION:' + OUTPAVILION END + 
 CASE WHEN OUTPAVANGLE ='' THEN '' ELSE '; PAVANGLE:' + OUTPAVANGLE END +
 CASE WHEN OUTPAVHEIGHT ='' THEN '' ELSE '; PAVHEIGHT:' + OUTPAVHEIGHT END + 
 CASE WHEN OUTCROWN ='' THEN '' ELSE '; CROWN:' + OUTCROWN END + 
 CASE WHEN OUTCROWNANGLE ='' THEN '' ELSE '; CROWNANGLE:' + OUTCROWNANGLE END + 
 CASE WHEN OUTCROWNHEIGHT ='' THEN '' ELSE '; CROWNHEIGHT:' + OUTCROWNHEIGHT END + 
 CASE WHEN OUTRATIO ='' THEN '' ELSE '; RATIO:' + OUTRATIO END + 
 CASE WHEN OUTSTAR_LENGTH ='' THEN '' ELSE '; STAR_LENGTH:' + OUTSTAR_LENGTH END + 
 CASE WHEN OUTLOWER_HALF ='' THEN '' ELSE '; LOWER_HALF:' + OUTLOWER_HALF END +*/
 CASE WHEN OUTRAPARATE ='' THEN '' ELSE '; RAPARATE:' + OUTRAPARATE END +
 CASE WHEN OUTRAPAAMT ='' THEN '' ELSE '; RAPAAMT:' + OUTRAPAAMT END +
 CASE WHEN OUTASKRATE ='' THEN '' ELSE '; ASKRATE:' + OUTASKRATE END +
 CASE WHEN OUTASKAMT ='' THEN '' ELSE '; ASKAMT:' + OUTASKAMT END +
 CASE WHEN OUTASKDISC ='' THEN '' ELSE '; ASKDISC:' + OUTASKDISC END +
 CASE WHEN OUTCOSTRATE ='' THEN '' ELSE '; COSTRATE:' + OUTCOSTRATE END +
 CASE WHEN OUTCOSTAMT ='' THEN '' ELSE '; COSTAMT:' + OUTCOSTAMT END +
 CASE WHEN OUTCOSTDISC ='' THEN '' ELSE '; COSTDISC:' + OUTCOSTDISC END AS RESROW FROM (
SELECT RNO,CASE WHEN PSHAPE IS NULL THEN ISNULL(SHAPE,'') ELSE '' END OUTSHAPE,
  CASE WHEN ISNUMERIC(ISNULL(CTS,0))=0 THEN CONVERT(VARCHAR,CTS) ELSE '' END OUTCTS,
  CASE WHEN PCOLOR IS NULL THEN ISNULL(COLOR,'') ELSE '' END OUTCOLOR,
  CASE WHEN PCLARITY IS NULL THEN ISNULL(CLARITY,'') ELSE '' END OUTCLARITY,
  CASE WHEN PCUT IS NULL THEN ISNULL(CUT,'') ELSE '' END OUTCUT,
  CASE WHEN PPOLISH IS NULL THEN ISNULL(POLISH,'') ELSE '' END OUTPOLISH,
  CASE WHEN PSYM IS NULL THEN ISNULL(SYM,'') ELSE '' END OUTSYM,
  CASE WHEN PFL IS NULL THEN ISNULL(FLOURENCE,'') ELSE '' END OUTFL,
  CASE WHEN PFLCOLOR IS NULL THEN ISNULL(FL_COLOR,'') ELSE '' END OUTFL_COLOR,
  CASE WHEN PGIRDLE IS NULL THEN ISNULL(GIRDLE,'') ELSE '' END OUTGIRDLE,
  CASE WHEN PCERT IS NULL THEN ISNULL(CERTIFICATE,'') ELSE '' END OUTCERT,
  CASE WHEN PLOCATION IS NULL THEN ISNULL(LOCATION,'') ELSE '' END OUTLOCATION,
  CASE WHEN ISNUMERIC(ISNULL(GIRDLEPER,0))=0 THEN CONVERT(VARCHAR,GIRDLEPER) ELSE '' END OUTGIRDLEPER,
  CASE WHEN ISNUMERIC(ISNULL(DEPTH,0))=0 THEN CONVERT(VARCHAR,DEPTH) ELSE '' END OUTDEPTH,
  CASE WHEN ISNUMERIC(ISNULL(DIA,0))=0 THEN CONVERT(VARCHAR,DIA) ELSE '' END OUTDIA,
  CASE WHEN ISNUMERIC(ISNULL(DIATABLE,0))=0 THEN CONVERT(VARCHAR,DIATABLE) ELSE '' END OUTDIATABLE,
  CASE WHEN ISNUMERIC(ISNULL(LENGTH,0))=0 THEN CONVERT(VARCHAR,LENGTH) ELSE '' END OUTLENGTH,
  CASE WHEN ISNUMERIC(ISNULL(WIDTH,0))=0 THEN CONVERT(VARCHAR,WIDTH) ELSE '' END OUTWIDTH,
  CASE WHEN ISNUMERIC(ISNULL(HEIGHT,0))=0 THEN CONVERT(VARCHAR,HEIGHT) ELSE '' END OUTHEIGHT,
  CASE WHEN ISNUMERIC(ISNULL(PAVILION,0))=0 THEN CONVERT(VARCHAR,PAVILION) ELSE '' END OUTPAVILION,
  CASE WHEN ISNUMERIC(ISNULL(PAVANGLE,0))=0 THEN CONVERT(VARCHAR,PAVANGLE) ELSE '' END OUTPAVANGLE,
  CASE WHEN ISNUMERIC(ISNULL(PAVHEIGHT,0))=0 THEN CONVERT(VARCHAR,PAVHEIGHT) ELSE '' END OUTPAVHEIGHT,
  CASE WHEN ISNUMERIC(ISNULL(CROWN,0))=0 THEN CONVERT(VARCHAR,CROWN) ELSE '' END OUTCROWN,
  CASE WHEN ISNUMERIC(ISNULL(CROWNANGLE,0))=0 THEN CONVERT(VARCHAR,CROWNANGLE) ELSE '' END OUTCROWNANGLE,
  CASE WHEN ISNUMERIC(ISNULL(CROWNHEIGHT,0))=0 THEN CONVERT(VARCHAR,CROWNHEIGHT) ELSE '' END OUTCROWNHEIGHT,
  CASE WHEN ISNUMERIC(ISNULL(RATIO,0))=0 THEN CONVERT(VARCHAR,RATIO) ELSE '' END OUTRATIO,
  CASE WHEN ISNUMERIC(ISNULL(STAR_LENGTH,0))=0 THEN CONVERT(VARCHAR,STAR_LENGTH) ELSE '' END OUTSTAR_LENGTH,
  CASE WHEN ISNUMERIC(ISNULL(LOWER_HALF,0))=0 THEN CONVERT(VARCHAR,LOWER_HALF) ELSE '' END OUTLOWER_HALF,
  CASE WHEN ISNUMERIC(ISNULL(RAPARATE,0))=0 THEN CONVERT(VARCHAR,RAPARATE) ELSE '' END OUTRAPARATE,
  CASE WHEN ISNUMERIC(ISNULL(RAPAAMT,0))=0 THEN CONVERT(VARCHAR,RAPAAMT) ELSE '' END OUTRAPAAMT,
  CASE WHEN ISNUMERIC(ISNULL(ASKRATE_FC,0))=0 THEN CONVERT(VARCHAR,ASKRATE_FC) ELSE '' END OUTASKRATE,
  CASE WHEN ISNUMERIC(ISNULL(ASKAMT_FC,0))=0 THEN CONVERT(VARCHAR,ASKAMT_FC) ELSE '' END OUTASKAMT,
  CASE WHEN ISNUMERIC(ISNULL(ASKDISC_FC,0))=0 THEN CONVERT(VARCHAR,ASKDISC_FC) ELSE '' END OUTASKDISC,
  CASE WHEN ISNUMERIC(ISNULL(COSTRATE_FC,0))=0 THEN CONVERT(VARCHAR,COSTRATE_FC) ELSE '' END OUTCOSTRATE,
  CASE WHEN ISNUMERIC(ISNULL(COSTAMT_FC,0))=0 THEN CONVERT(VARCHAR,COSTAMT_FC) ELSE '' END OUTCOSTAMT,
  CASE WHEN ISNUMERIC(ISNULL(COSTDISC_FC,0))=0 THEN CONVERT(VARCHAR,COSTDISC_FC) ELSE '' END OUTCOSTDISC
  FROM (
SELECT ROW_NUMBER() OVER(ORDER BY STONEID ) AS RNO,
COMPCD,STONEID,SHAPE,CTS,COLOR,CLARITY,CUT,POLISH,SYM,FLOURENCE,FL_COLOR,INCLUSION,HA,LUSTER,GIRDLE,GIRDLEPER,GIRDLE_CONDITION,
CULET,MILKY,SHADE,NATTS,NATURAL,DEPTH,DIATABLE,LENGTH,WIDTH,HEIGHT,CROWN,CROWNANGLE,CROWNHEIGHT,PAVILION,PAVANGLE,PAVHEIGHT,
MEASUREMENT,RATIO,PAIR,STAR_LENGTH,LOWER_HALF,KEY_TO_SYMBOL,REPORT_COMMENT,CERTIFICATE,CERTNO,RAPARATE,RAPAAMT,CURDATE,LOCATION,
LEGEND1,LEGEND2,LEGEND3,ASKRATE_FC,ASKDISC_FC,ASKAMT_FC,COSTRATE_FC,COSTDISC_FC,COSTAMT_FC,DIA,COLORDESC,BARCODE,INSCRIPTION,
NEW_CERT,MEMBER_COMMENT
 FROM EXCEL_GRADDET
)GD
LEFT JOIN (SELECT PROCNM PSHAPE FROM PROCMAS WHERE PROCGROUP='SHAPE')SHPMAS ON GD.SHAPE=SHPMAS.PSHAPE
LEFT JOIN (SELECT PROCNM PCOLOR FROM PROCMAS WHERE PROCGROUP='COLOR')COLMAS ON GD.COLOR=COLMAS.PCOLOR
LEFT JOIN (SELECT PROCNM PCLARITY FROM PROCMAS WHERE PROCGROUP='CLARITY')CLRMAS ON GD.CLARITY=CLRMAS.PCLARITY
LEFT JOIN (SELECT PROCNM PCUT FROM PROCMAS WHERE PROCGROUP='CUT')CUTMAS ON GD.CUT=CUTMAS.PCUT
LEFT JOIN (SELECT PROCNM PPOLISH FROM PROCMAS WHERE PROCGROUP='POLISH')POLMAS ON GD.POLISH=POLMAS.PPOLISH
LEFT JOIN (SELECT PROCNM PSYM FROM PROCMAS WHERE PROCGROUP='SYM')SYMMAS ON GD.SYM=SYMMAS.PSYM
LEFT JOIN (SELECT PROCNM PFL FROM PROCMAS WHERE PROCGROUP='FLOURENCE')FLMAS ON GD.FLOURENCE=FLMAS.PFL
LEFT JOIN (SELECT PROCNM PFLCOLOR FROM PROCMAS WHERE PROCGROUP='FL_COLOR')FL_COLMAS ON GD.FL_COLOR=FL_COLMAS.PFLCOLOR
LEFT JOIN (SELECT PROCNM PGIRDLE FROM PROCMAS WHERE PROCGROUP='GIRDLE')GIRDLEMAS ON GD.GIRDLE=GIRDLEMAS.PGIRDLE
LEFT JOIN (SELECT PROCNM PCERT FROM PROCMAS WHERE PROCGROUP='CERTIFICATE')CERTMAS ON GD.CERTIFICATE=CERTMAS.PCERT
LEFT JOIN (SELECT PROCNM PLOCATION FROM PROCMAS WHERE PROCGROUP='LOCATION')LOCATIONMAS ON GD.LOCATION=LOCATIONMAS.PLOCATION
 ) AS TEMP_TABLE 
 )
 SELECT RNO,RESROW
 FROM CTE
 WHERE RESROW <>''
 
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE FUNCTION DBO.FUNC_EXCEL_STOCK_ERRORS() RETURNS   
@ERROR_LIST TABLE( RNO NUMERIC, ERROR_DESC VARCHAR(MAX)) AS   
BEGIN  
 DECLARE @CNT NUMERIC;  
 SELECT @CNT=COUNT(1) FROM [dbo].[GET_EXCEL_ERRORLIST]() ;  
   
 IF @CNT>0 BEGIN  
 INSERT INTO @ERROR_LIST  
  SELECT * FROM [dbo].[GET_EXCEL_ERRORLIST]();  
 END  
 ELSE BEGIN  
  /*INSERT INTO @ERROR_LIST  
   SELECT null,null  */
   RETURN
 END  
    
 RETURN  
END;
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE PROCEDURE [dbo].[auto_updates_fromSetttings]
@ReturnVal varchar(100) output
AS  
BEGIN  
	DECLARE  
		@SYSDATE DATETIME,
		@DEACTIVATE_DAYS INT,
		@CART_DELETE_DAYS INT,
		@BUY_REQUEST_DELETE_DAYS INT
	BEGIN  
		SELECT @SYSDATE = GETDATE()
		
		SELECT 
			@CART_DELETE_DAYS = SC_DELETE_DAYS, 
			@DEACTIVATE_DAYS = CLIENT_DEACTIVATE_DAYS, 
			@BUY_REQUEST_DELETE_DAYS = SCBR_DELETE_DAYS
		FROM SETTINGS
		
		BEGIN  
			UPDATE CLIENTMASTER SET STATUS = 'P'
			WHERE NOT DATEDIFF(DAY,statusupdatedon, @SYSDATE) < @DEACTIVATE_DAYS
			AND STATUS <> 'N'
			AND CLIENTCD NOT IN
			(
				SELECT CLIENTCD FROM CLIENTLOGINHISTORY 
				WHERE DATEDIFF(DAY,CLOGINTIME,@SYSDATE) < @DEACTIVATE_DAYS
			)				
		
			UPDATE SHOPPINGCART SET SC_STATUS='O' where sc_delete_date <= @SYSDATE AND SC_STATUS='I'   
		
			UPDATE SHOPPINGCART SET SC_STATUS='O' where sc_delete_date <= @SYSDATE AND SC_STATUS='B'   
		
			IF @@error <> 0 goto Err_Handler  
			SET @ReturnVal = 0  
			RETURN
		END
		
		Err_Handler:  
		SET @ReturnVal = -1  
		RETURN

		CleanUp:  
		SET @ReturnVal = 0  
		
		RETURN
	END
END

---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
