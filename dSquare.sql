USE [dsquarefancy]
GO
/****** Object:  Table [dbo].[UserTypeMaster]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserTypeMaster](
	[UTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [char](2) NOT NULL,
	[UserDesc] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsDeleted] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ticketmas]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ticketmas](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[PersonName] [varchar](100) NULL,
	[emailid] [varchar](200) NULL,
	[contact1] [varchar](100) NULL,
	[countrycd] [numeric](5, 0) NULL,
	[remarks] [varchar](4000) NULL,
	[status] [varchar](2) NULL,
	[curdate] [datetime] NULL,
	[UpdatedBy] [numeric](5, 0) NULL,
	[StatusUpdatedOn] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[syncdet]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[syncdet](
	[SyncID] [int] IDENTITY(1,1) NOT NULL,
	[Stoneid] [varchar](50) NOT NULL,
	[curdate] [datetime] NULL,
	[NA_sentdate] [datetime] NULL,
	[NA_status] [varchar](10) NULL,
	[WL_sentdate] [varchar](10) NULL,
	[WL_status] [varchar](10) NULL,
	[na_daily_sentdate] [datetime] NULL,
	[na_Weekly_sentdate] [datetime] NULL,
	[na_biWeekly_sentdate] [datetime] NULL,
	[na_monthly_sentdate] [datetime] NULL,
	[na_daily_status] [varchar](1) NULL,
	[na_Weekly_Status] [varchar](1) NULL,
	[na_biWeekly_Status] [varchar](1) NULL,
	[na_monthly_Status] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsersTable]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsersTable](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[Gender] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[DOB] [varchar](50) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[Designation] [varchar](50) NOT NULL,
	[ReferenceNumber] [varchar](50) NOT NULL,
	[Address] [varchar](250) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[Zipcode] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[Phoneno1] [varchar](50) NOT NULL,
	[Phoneno2] [varchar](50) NOT NULL,
	[FAX] [varchar](50) NOT NULL,
	[Mobile1] [varchar](50) NOT NULL,
	[Mobile2] [varchar](50) NOT NULL,
	[EmailId] [varchar](50) NOT NULL,
	[Website] [varchar](50) NOT NULL,
	[UserLevel] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserSearchHistory]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserSearchHistory](
	[SID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SearchName] [varchar](100) NULL,
	[SAVEDON] [datetime] NULL,
	[CID] [int] NULL,
	[SHAPE] [varchar](max) NULL,
	[CTS] [varchar](20) NULL,
	[MCTS] [varchar](max) NULL,
	[COLOR] [varchar](50) NULL,
	[MCOLOR] [varchar](max) NULL,
	[CLARITY] [varchar](50) NULL,
	[MCLARITY] [varchar](max) NULL,
	[CUT] [varchar](60) NULL,
	[MCUT] [varchar](max) NULL,
	[POLISH] [varchar](50) NULL,
	[MPOLISH] [varchar](max) NULL,
	[SYM] [varchar](50) NULL,
	[MSYM] [varchar](max) NULL,
	[FL] [varchar](50) NULL,
	[MFL] [varchar](max) NULL,
	[CERTIFICATE] [varchar](max) NULL,
	[CERTNO] [varchar](max) NULL,
	[RATE] [varchar](60) NULL,
	[DISCPER] [varchar](60) NULL,
	[AMT] [varchar](60) NULL,
	[RAPARATE] [varchar](60) NULL,
	[RAPAAMT] [varchar](60) NULL,
	[INCLUSION] [varchar](max) NULL,
	[STONEID] [varchar](max) NULL,
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usermas]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usermas](
	[UserCd] [int] IDENTITY(1,1) NOT NULL,
	[UTypeID] [int] NOT NULL,
	[UserName] [varchar](100) NULL,
	[Password] [varchar](100) NOT NULL,
	[Title] [varchar](5) NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Designation] [varchar](100) NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zipcode] [varchar](10) NULL,
	[CountryID] [int] NULL,
	[Phone_CountryCode] [varchar](10) NULL,
	[Phone_STDCode] [varchar](10) NULL,
	[Phone_Number] [varchar](20) NULL,
	[Mobile_CountryCode] [varchar](10) NULL,
	[Mobile_Number] [varchar](15) NULL,
	[EmailID] [varchar](75) NOT NULL,
	[UserRights] [varchar](2000) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsDeleted] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UPLOAD_EXCEL_FORMAT]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UPLOAD_EXCEL_FORMAT](
	[UPLOAD_TYPE] [varchar](30) NOT NULL,
	[COLUMN_NAME] [varchar](60) NOT NULL,
	[SHOWCOLUMN_NAME] [varchar](60) NULL,
	[ISREQUIRED] [bit] NULL,
	[ORD] [numeric](18, 0) NULL,
	[COLUMN_MAPPING] [varchar](max) NULL,
 CONSTRAINT [PK_UPLOADEXCEL_COLNM] PRIMARY KEY CLUSTERED 
(
	[UPLOAD_TYPE] ASC,
	[COLUMN_NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SIZEMAS]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SIZEMAS](
	[SIZECD] [numeric](5, 0) NOT NULL,
	[FCTS] [numeric](8, 3) NULL,
	[TCTS] [numeric](8, 3) NULL,
	[SIZENM] [varchar](20) NULL,
	[STATUS] [varchar](1) NULL,
	[ORD] [numeric](5, 0) NULL,
 CONSTRAINT [PK_SIZEMAS_SIZECD] PRIMARY KEY CLUSTERED 
(
	[SIZECD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SIZEMAS_SIZENM] UNIQUE NONCLUSTERED 
(
	[SIZENM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SHAPEMAS]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SHAPEMAS](
	[SHAPECD] [numeric](5, 0) NOT NULL,
	[SHAPENM] [varchar](20) NULL,
	[SHORTNM] [varchar](20) NULL,
	[STATUS] [varchar](1) NULL,
	[ORD] [numeric](5, 0) NULL,
 CONSTRAINT [PK_SHAPEMAS_SHAPECD] PRIMARY KEY CLUSTERED 
(
	[SHAPECD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SHAPEMAS_SHAPENM] UNIQUE NONCLUSTERED 
(
	[SHAPENM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SHAPEMAS_SHORTNM] UNIQUE NONCLUSTERED 
(
	[SHORTNM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SetVal]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SetVal]
@ptype varchar(MAX),
@pval numeric(10,2)=0,
@pflag varchar(30)
as
begin
DECLARE @PQRY VARCHAR(MAX);
	IF UPPER(@pflag)='UPDATE' BEGIN
		SET @PQRY = 'UPDATE SETTINGS SET '+ @PTYPE +'='+@PVAL 
	END ELSE IF	UPPER(@pflag)='SELECT' BEGIN
		SET @PQRY = N'SELECT '+ @PTYPE +' FROM SETTINGS';
	END
	EXECUTE (@PQRY);
end;
GO
/****** Object:  Table [dbo].[settings]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[settings](
	[NEW_ARRIVAL_DAYS] [numeric](5, 0) NULL,
	[sc_delete_days] [numeric](10, 0) NULL,
	[client_deactivate_days] [numeric](5, 0) NULL,
	[Webclient_name] [varchar](200) NULL,
	[webclientmailFrom] [varchar](50) NULL,
	[SCBR_DELETE_DAYS] [numeric](10, 0) NULL,
	[QM_DELETE_DAYS] [numeric](10, 0) NULL,
	[bidLimitValue] [numeric](5, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SearchQry]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SearchQry](
	[SID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SearchQry] [varchar](5000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SearchHistory]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SearchHistory](
	[SID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SearchName] [varchar](100) NULL,
	[CID] [int] NULL,
	[SHAPE] [varchar](1000) NULL,
	[FCTS] [varchar](20) NULL,
	[TCTS] [varchar](20) NULL,
	[FCOLOR] [varchar](20) NULL,
	[TCOLOR] [varchar](20) NULL,
	[FCLARITY] [varchar](20) NULL,
	[TCLARITY] [varchar](20) NULL,
	[SAVEDON] [datetime] NULL,
	[FPOLISH] [varchar](1000) NULL,
	[FSYM] [varchar](1000) NULL,
	[FFL] [varchar](1000) NULL,
	[CERT] [varchar](1000) NULL,
	[FRATE] [varchar](20) NULL,
	[TRATE] [varchar](20) NULL,
	[FDISCPER] [varchar](20) NULL,
	[TDISCPER] [varchar](20) NULL,
	[FAMT] [varchar](20) NULL,
	[TAMT] [varchar](20) NULL,
	[FINCLUSION] [varchar](1000) NULL,
	[FSTONEID] [varchar](100) NULL,
	[FTABLEPER] [varchar](20) NULL,
	[TTABLEPER] [varchar](20) NULL,
	[FDEPTHPER] [varchar](20) NULL,
	[TDEPTHPER] [varchar](20) NULL,
	[FGIRDLEPER] [varchar](20) NULL,
	[TGIRDLEPER] [varchar](20) NULL,
	[FORD1] [varchar](200) NULL,
	[FORD2] [varchar](200) NULL,
	[FORD3] [varchar](200) NULL,
	[FORD4] [varchar](200) NULL,
	[FORD5] [varchar](200) NULL,
	[FORD6] [varchar](200) NULL,
	[FCUT] [varchar](20) NULL,
	[TCUT] [varchar](20) NULL,
	[PAGESIZE] [varchar](20) NULL,
	[flengthmm] [varchar](100) NULL,
	[tlengthmm] [varchar](100) NULL,
	[fwidthmm] [varchar](100) NULL,
	[twidthmm] [varchar](100) NULL,
	[fdepthmm] [varchar](100) NULL,
	[tdepthmm] [varchar](100) NULL,
	[location] [varchar](100) NULL,
	[flcolor] [varchar](100) NULL,
	[culet] [varchar](100) NULL,
	[AUTO] [varchar](1) NULL,
	[fratiomm] [varchar](100) NULL,
	[tratiomm] [varchar](100) NULL,
	[nastatus] [varchar](10) NULL,
	[omstatus] [varchar](10) NULL,
	[avstatus] [varchar](10) NULL,
	[type] [varchar](30) NULL,
	[uid] [numeric](10, 0) NULL,
	[CERTNO] [varchar](100) NULL,
	[SHOWONLY] [varchar](12) NULL,
	[isFancy] [char](1) NULL,
	[MCOLOR] [varchar](max) NULL,
	[MCLARITY] [varchar](max) NULL,
	[MCUT] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RAPCOMPARE]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RAPCOMPARE](
	[SHAPE] [varchar](50) NULL,
	[COLOR] [varchar](50) NULL,
	[CLARITY] [varchar](50) NULL,
	[CTS] [float] NULL,
	[rate] [numeric](10, 2) NULL,
	[CUT] [varchar](50) NULL,
	[POLISH] [varchar](50) NULL,
	[SYMM] [varchar](50) NULL,
	[LAB] [varchar](50) NULL,
	[PARTYNAME] [varchar](200) NULL,
	[PARTYCD] [varchar](100) NULL,
	[DISCPER] [numeric](10, 2) NULL,
	[raprate] [numeric](10, 2) NULL,
	[PRICE] [float] NULL,
	[RAP_PRICE] [float] NULL,
	[CurrDate] [datetime] NULL,
	[SHADE] [varchar](100) NULL,
	[StoneCount] [int] NULL,
	[orgdiscper] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[quotemas]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[quotemas](
	[quoteid] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[cid] [numeric](10, 0) NULL,
	[curdate] [datetime] NULL,
	[status] [varchar](1) NULL,
	[completedate] [datetime] NULL,
	[QM_DELETE_DATE] [datetime] NULL,
 CONSTRAINT [pk_quotemas_quoteid] PRIMARY KEY CLUSTERED 
(
	[quoteid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[procmas]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[procmas](
	[procgroup] [varchar](20) NULL,
	[proccd] [numeric](10, 0) NULL,
	[procnm] [varchar](100) NULL,
	[shortnm] [varchar](100) NULL,
	[ord] [numeric](10, 0) NULL,
	[status] [varchar](1) NULL,
	[fancy_color_status] [varchar](1) NULL,
	[isChangeable] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[NVL_NUMERIC]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NVL_NUMERIC](@PVAL1 NUMERIC(20),@PVAL2 NUMERIC(20)) RETURNS NUMERIC(20)
BEGIN 
   DECLARE
     @VVAL NUMERIC(20)
  BEGIN
     
		IF @PVAL1 IS NULL SET @VVAL=@PVAL2
		ELSE SET @VVAL = @PVAL1
		   
     RETURN @VVAL
  END
END
GO
/****** Object:  UserDefinedFunction [dbo].[NVL_CHAR]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[NVL_CHAR](@PVAL1 VARCHAR(1000),@PVAL2 VARCHAR(1000)) RETURNS VARCHAR(1000)
BEGIN 
   DECLARE
     @VVAL VARCHAR(1000)
  BEGIN
     
		IF @PVAL1 IS NULL SET @VVAL=@PVAL2
		ELSE SET @VVAL = @PVAL1
		   
     RETURN @VVAL
  END
END
GO
/****** Object:  UserDefinedFunction [dbo].[nvl]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[nvl](@pval1 numeric,@pval2 numeric) returns int
	as
	begin
	  declare
	    @pval numeric
	   begin
	     SET @pval = CASE WHEN @pval1 = NULL then @pval2 end
	     return @pval
	   END 
	end
GO
/****** Object:  UserDefinedFunction [dbo].[initcap]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[initcap] ( @InputString varchar(4000) ) 
RETURNS VARCHAR(4000)
AS
BEGIN

DECLARE @Index          INT
DECLARE @Char           CHAR(1)
DECLARE @PrevChar       CHAR(1)
DECLARE @OutputString   VARCHAR(255)

SET @OutputString = LOWER(@InputString)
SET @Index = 1

WHILE @Index <= LEN(@InputString)
BEGIN
    SET @Char     = SUBSTRING(@InputString, @Index, 1)
    SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
                         ELSE SUBSTRING(@InputString, @Index - 1, 1)
                    END

    IF @PrevChar IN (' ', ';', ':', '!', '?', ',', '.', '_', '-', '/', '&', '''', '(')
    BEGIN
        IF @PrevChar != '''' OR UPPER(@Char) != 'S'
            SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char))
    END

    SET @Index = @Index + 1
END

RETURN @OutputString

END
GO
/****** Object:  Table [dbo].[guestmaster]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[guestmaster](
	[GUEST_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[graddet_temp]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[graddet_temp](
	[COMPCD] [numeric](5, 0) NULL,
	[STONEID] [varchar](30) NULL,
	[SHAPE] [varchar](20) NULL,
	[CTS] [numeric](10, 3) NULL,
	[COLOR] [varchar](10) NULL,
	[CLARITY] [varchar](10) NULL,
	[CUT] [varchar](20) NULL,
	[POLISH] [varchar](20) NULL,
	[SYM] [varchar](20) NULL,
	[FLOURENCE] [varchar](20) NULL,
	[FL_COLOR] [varchar](20) NULL,
	[INCLUSION] [varchar](20) NULL,
	[HA] [varchar](20) NULL,
	[LUSTER] [varchar](20) NULL,
	[GIRDLE] [varchar](20) NULL,
	[GIRDLE_CONDITION] [varchar](20) NULL,
	[CULET] [varchar](20) NULL,
	[MILKY] [varchar](20) NULL,
	[SHADE] [varchar](20) NULL,
	[NATTS] [varchar](20) NULL,
	[NATURAL] [varchar](20) NULL,
	[DEPTH] [numeric](5, 2) NULL,
	[DIATABLE] [numeric](5, 2) NULL,
	[LENGTH] [numeric](5, 2) NULL,
	[WIDTH] [numeric](5, 2) NULL,
	[PAVILION] [numeric](5, 2) NULL,
	[CROWN] [numeric](5, 2) NULL,
	[PAVANGLE] [numeric](5, 2) NULL,
	[CROWNANGLE] [numeric](5, 2) NULL,
	[HEIGHT] [numeric](5, 2) NULL,
	[PAVHEIGHT] [numeric](5, 2) NULL,
	[CROWNHEIGHT] [numeric](5, 2) NULL,
	[MEASUREMENT] [varchar](30) NULL,
	[RATIO] [numeric](5, 2) NULL,
	[PAIR] [varchar](10) NULL,
	[STAR_LENGTH] [numeric](10, 2) NULL,
	[LOWER_HALF] [numeric](10, 2) NULL,
	[KEY_TO_SYMBOL] [varchar](300) NULL,
	[REPORT_COMMENT] [varchar](300) NULL,
	[CERTIFICATE] [varchar](20) NULL,
	[CERTNO] [varchar](20) NULL,
	[RAPARATE] [numeric](10, 2) NULL,
	[RAPAAMT] [numeric](14, 2) NULL,
	[CURDATE] [datetime] NULL,
	[LOCATION] [varchar](20) NULL,
	[LEGEND1] [varchar](20) NULL,
	[LEGEND2] [varchar](20) NULL,
	[LEGEND3] [varchar](20) NULL,
	[ASKRATE_FC] [numeric](15, 2) NULL,
	[ASKDISC_FC] [numeric](15, 2) NULL,
	[ASKAMT_FC] [numeric](15, 2) NULL,
	[COSTRATE_FC] [numeric](15, 2) NULL,
	[COSTDISC_FC] [numeric](15, 2) NULL,
	[COSTAMT_FC] [numeric](15, 2) NULL,
	[WEB_CLIENTID] [numeric](10, 0) NULL,
	[GIRDLEPER] [varchar](20) NULL,
	[DIA] [numeric](5, 2) NULL,
	[COLORDESC] [varchar](100) NULL,
	[BARCODE] [varchar](30) NULL,
	[INSCRIPTION] [varchar](20) NULL,
	[NEW_CERT] [varchar](2) NULL,
	[MEMBER_COMMENT] [varchar](300) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRADDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRADDET](
	[COMPCD] [numeric](5, 0) NULL,
	[STONEID] [varchar](30) NULL,
	[SHAPE] [varchar](20) NULL,
	[CTS] [numeric](10, 2) NULL,
	[COLOR] [varchar](10) NULL,
	[CLARITY] [varchar](10) NULL,
	[CUT] [varchar](20) NULL,
	[POLISH] [varchar](20) NULL,
	[SYM] [varchar](20) NULL,
	[FLOURENCE] [varchar](20) NULL,
	[FL_COLOR] [varchar](20) NULL,
	[INCLUSION] [varchar](20) NULL,
	[HA] [varchar](20) NULL,
	[LUSTER] [varchar](20) NULL,
	[GIRDLE] [varchar](20) NULL,
	[GIRDLE_CONDITION] [varchar](20) NULL,
	[CULET] [varchar](20) NULL,
	[MILKY] [varchar](20) NULL,
	[SHADE] [varchar](20) NULL,
	[NATTS] [varchar](20) NULL,
	[NATURAL] [varchar](20) NULL,
	[DEPTH] [numeric](5, 2) NULL,
	[DIATABLE] [numeric](5, 2) NULL,
	[LENGTH] [numeric](5, 2) NULL,
	[WIDTH] [numeric](5, 2) NULL,
	[PAVILION] [numeric](5, 2) NULL,
	[CROWN] [numeric](5, 2) NULL,
	[PAVANGLE] [numeric](5, 2) NULL,
	[CROWNANGLE] [numeric](5, 2) NULL,
	[HEIGHT] [numeric](5, 2) NULL,
	[PAVHEIGHT] [numeric](5, 2) NULL,
	[CROWNHEIGHT] [numeric](5, 2) NULL,
	[MEASUREMENT] [varchar](30) NULL,
	[RATIO] [numeric](5, 2) NULL,
	[PAIR] [varchar](10) NULL,
	[STAR_LENGTH] [numeric](10, 2) NULL,
	[LOWER_HALF] [numeric](10, 2) NULL,
	[KEY_TO_SYMBOL] [varchar](300) NULL,
	[REPORT_COMMENT] [varchar](300) NULL,
	[CERTIFICATE] [varchar](20) NULL,
	[CERTNO] [varchar](20) NULL,
	[RAPARATE] [numeric](10, 2) NULL,
	[RAPAAMT] [numeric](14, 2) NULL,
	[CURDATE] [datetime] NULL,
	[LOCATION] [varchar](20) NULL,
	[LEGEND1] [varchar](20) NULL,
	[LEGEND2] [varchar](20) NULL,
	[LEGEND3] [varchar](20) NULL,
	[ASKRATE_FC] [numeric](15, 2) NULL,
	[ASKDISC_FC] [numeric](15, 2) NULL,
	[ASKAMT_FC] [numeric](15, 2) NULL,
	[COSTRATE_FC] [numeric](15, 2) NULL,
	[COSTDISC_FC] [numeric](15, 2) NULL,
	[COSTAMT_FC] [numeric](15, 2) NULL,
	[WEB_CLIENTID] [numeric](10, 0) NULL,
	[wl_rej_status] [varchar](50) NULL,
	[GIRDLEPER] [varchar](20) NULL,
	[DIA] [numeric](5, 2) NULL,
	[COLORDESC] [varchar](100) NULL,
	[BARCODE] [varchar](30) NULL,
	[INSCRIPTION] [varchar](20) NULL,
	[NEW_CERT] [varchar](2) NULL,
	[MEMBER_COMMENT] [varchar](300) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[getordchar]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getordchar](@pval NUMERIC(5))
RETURNS VARCHAR(100)
AS
BEGIN
  RETURN (RIGHT(REPLICATE('0',8) + CAST(@pval AS VARCHAR(8)),8))
END
GO
/****** Object:  UserDefinedFunction [dbo].[getorgparam]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getorgparam] (
@PARAM VARCHAR(100)
) 
RETURNS VARCHAR(100)
AS
BEGIN
		DECLARE
	    @VORGPARAM VARCHAR(100);

		IF RIGHT(@PARAM,1) IN ('+','-') AND LEN(@PARAM) <> 1 
			BEGIN
				SET @VORGPARAM = SUBSTRING(@PARAM,1,LEN(@PARAM)-1);
			END
		ELSE
			BEGIN
				SET @VORGPARAM=@PARAM;
			END 
			
		RETURN @VORGPARAM
END
GO
/****** Object:  UserDefinedFunction [dbo].[GET_VALUES]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GET_VALUES] (
@PFLAG varchar(50),
@pcts numeric(15,2),
@PRAPARATE numeric(15,2),
@PDISC NUMERIC(5,2) 
)
RETURNS NUMERIC(15,2)
AS
BEGIN
	DECLARE
	    @VRATE NUMERIC(15,2),
		@VAMT NUMERIC(15,2)	,
		@VVAL NUMERIC(15,2)
	BEGIN
	    IF @PDISC=0 
	    BEGIN
			  SET @VRATE = 0
		END
			  
		ELSE
		BEGIN
		  SET @VRATE = ROUND((@PRAPARATE * (100-@PDISC) )/100,2)  
		END 
		
		SET @VAMT = round(@VRATE * @PCTS,2)
	END
	
    
    IF @PFLAG = 'RATE' SET @VVAL=@VRATE
	ELSE IF @PFLAG = 'AMT' SET @VVAL =@VAMT
	ELSE SET @VVAL = 0
    
    RETURN @VVAL
	
	
	
END
GO
/****** Object:  Table [dbo].[dual]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dual](
	[dummy] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EXCEL_GRADDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EXCEL_GRADDET](
	[COMPCD] [varchar](30) NULL,
	[STONEID] [varchar](30) NULL,
	[SHAPE] [varchar](20) NULL,
	[CTS] [varchar](30) NULL,
	[COLOR] [varchar](10) NULL,
	[CLARITY] [varchar](10) NULL,
	[CUT] [varchar](20) NULL,
	[POLISH] [varchar](20) NULL,
	[SYM] [varchar](20) NULL,
	[FLOURENCE] [varchar](20) NULL,
	[FL_COLOR] [varchar](20) NULL,
	[INCLUSION] [varchar](20) NULL,
	[HA] [varchar](20) NULL,
	[LUSTER] [varchar](20) NULL,
	[GIRDLE] [varchar](20) NULL,
	[GIRDLE_CONDITION] [varchar](20) NULL,
	[CULET] [varchar](20) NULL,
	[MILKY] [varchar](20) NULL,
	[SHADE] [varchar](20) NULL,
	[NATTS] [varchar](20) NULL,
	[NATURAL] [varchar](20) NULL,
	[DEPTH] [varchar](30) NULL,
	[DIATABLE] [varchar](30) NULL,
	[LENGTH] [varchar](30) NULL,
	[WIDTH] [varchar](30) NULL,
	[PAVILION] [varchar](30) NULL,
	[CROWN] [varchar](30) NULL,
	[PAVANGLE] [varchar](30) NULL,
	[CROWNANGLE] [varchar](30) NULL,
	[HEIGHT] [varchar](30) NULL,
	[PAVHEIGHT] [varchar](30) NULL,
	[CROWNHEIGHT] [varchar](30) NULL,
	[MEASUREMENT] [varchar](30) NULL,
	[RATIO] [varchar](30) NULL,
	[PAIR] [varchar](30) NULL,
	[STAR_LENGTH] [varchar](30) NULL,
	[LOWER_HALF] [varchar](30) NULL,
	[KEY_TO_SYMBOL] [varchar](300) NULL,
	[REPORT_COMMENT] [varchar](300) NULL,
	[CERTIFICATE] [varchar](20) NULL,
	[CERTNO] [varchar](20) NULL,
	[RAPARATE] [varchar](30) NULL,
	[RAPAAMT] [varchar](30) NULL,
	[CURDATE] [varchar](30) NULL,
	[LOCATION] [varchar](20) NULL,
	[LEGEND1] [varchar](20) NULL,
	[LEGEND2] [varchar](20) NULL,
	[LEGEND3] [varchar](20) NULL,
	[ASKRATE_FC] [varchar](30) NULL,
	[ASKDISC_FC] [varchar](30) NULL,
	[ASKAMT_FC] [varchar](30) NULL,
	[COSTRATE_FC] [varchar](30) NULL,
	[COSTDISC_FC] [varchar](30) NULL,
	[COSTAMT_FC] [varchar](30) NULL,
	[WEB_CLIENTID] [varchar](30) NULL,
	[wl_rej_status] [varchar](50) NULL,
	[GIRDLEPER] [varchar](20) NULL,
	[DIA] [varchar](30) NULL,
	[COLORDESC] [varchar](100) NULL,
	[BARCODE] [varchar](30) NULL,
	[INSCRIPTION] [varchar](20) NULL,
	[NEW_CERT] [varchar](2) NULL,
	[MEMBER_COMMENT] [varchar](300) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Insert_datasynclog]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_datasynclog]
@ReturnVal int output,
@Description varchar(4000)
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

 		BEGIN
			
			insert into datasynclog (curdate,description) values (@SavedOn,@Description)
				
			SET @ReturnVal = 0
		
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			
			CleanUp:
				SET @ReturnVal = 0
		END
		
    
END
GO
/****** Object:  Table [dbo].[datalog]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[datalog](
	[dataID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[curdate] [datetime] NULL,
	[Description] [varchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[CSVToTable]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CSVToTable] ( @StringInput VARCHAR(8000) )
RETURNS @OutputTable TABLE ( [String] VARCHAR(10) )
AS
BEGIN

    DECLARE @String    VARCHAR(10)

    WHILE LEN(@StringInput) > 0
    BEGIN
        SET @String      = LEFT(@StringInput, 
                                ISNULL(NULLIF(CHARINDEX(',', @StringInput) - 1, -1),
                                LEN(@StringInput)))
        SET @StringInput = SUBSTRING(@StringInput,
                                     ISNULL(NULLIF(CHARINDEX(',', @StringInput), 0),
                                     LEN(@StringInput)) + 1, LEN(@StringInput))

        INSERT INTO @OutputTable ( [String] )
        VALUES ( @String )
    END
    
    RETURN
END
GO
/****** Object:  Table [dbo].[companydet]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[companydet](
	[type] [varchar](10) NULL,
	[address] [varchar](4000) NULL,
	[bankdetails] [varchar](4000) NULL,
	[routingdetails] [varchar](4000) NULL,
	[phonedetails] [varchar](1000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COLORMAS]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COLORMAS](
	[COLORCD] [numeric](5, 0) NOT NULL,
	[COLORNM] [varchar](20) NULL,
	[STATUS] [varchar](1) NULL,
	[ORD] [numeric](5, 0) NULL,
 CONSTRAINT [PK_COLORMAS_COLORCD] PRIMARY KEY CLUSTERED 
(
	[COLORCD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_COLORMAS_COLORNM] UNIQUE NONCLUSTERED 
(
	[COLORNM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appointments]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appointments](
	[AppID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](10) NULL,
	[CurDate] [datetime] NULL,
	[CompanyName] [varchar](100) NULL,
	[PersonName] [varchar](100) NULL,
	[emailid] [varchar](200) NULL,
	[contact1] [varchar](100) NULL,
	[contact2] [varchar](100) NULL,
	[interested] [varchar](4000) NULL,
	[appdate] [datetime] NULL,
	[totperson] [numeric](5, 0) NULL,
	[remarks] [varchar](4000) NULL,
	[status] [varchar](2) NULL,
	[UpdatedBy] [numeric](5, 0) NULL,
	[StatusUpdatedOn] [datetime] NULL,
	[ftime] [varchar](10) NULL,
	[ttime] [varchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[adat_calc2]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[adat_calc2](
	@PADAT numeric(15,2),
	@paddlessper NUMERIC(5,2) ,
	@PRAPARATE numeric(15,2),
	@PASKRATE_FC numeric(15,2),
	@PASKDISC_FC numeric(15,2),
	@PASKAMT_FC numeric(15,2),
	@pcts numeric(15,2),
	@PTYPE varchar)
RETURNS numeric
AS
	BEGIN
		DECLARE
			@VASKRATE_FC NUMERIC(15,2),@VASKDISC_FC NUMERIC(15,2),@VASKAMT_FC NUMERIC(15,2),@VVAL NUMERIC(15,2)
		BEGIN
				IF @PADAT <> 0 BEGIN
					IF @PADAT < 0 BEGIN
						SET @VASKRATE_FC = ROUND(@PASKRATE_FC / ((100 - ABS(@PADAT)) / 100), 2)	
						SET @VASKDISC_FC = ROUND( 100 - ((@VASKRATE_FC / @PRAPARATE) * 100) ,2)  
					END 
					IF @PADAT > 0 BEGIN
						SET @VASKRATE_FC = ROUND(@PASKRATE_FC * ((100 - ABS(@PADAT)) / 100), 2)
						SET @VASKDISC_FC = ROUND( 100 - ((@VASKRATE_FC / @PRAPARATE) * 100) ,2)           
					END 
				END 
			
		  SET @VVAL = @VASKRATE_FC
   RETURN @VVAL
END
END
GO
/****** Object:  UserDefinedFunction [dbo].[admin_adat_calc]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[admin_adat_calc](
@PADAT numeric(15,2),
@paddlessper NUMERIC(5,2) ,
@PRAPARATE numeric(15,2),
@PCOSTRATE_FC numeric(15,2),
@PCOSTDISC_FC numeric(15,2),
@PCOSTAMT_FC numeric(15,2),
@pcts numeric(15,2),
@PTYPE varchar(50))
RETURNS NUMERIC(15,2)
AS
BEGIN
	DECLARE
		@VCOSTRATE_FC NUMERIC(15,2),@VCOSTDISC_FC NUMERIC(15,2),@VCOSTAMT_FC NUMERIC(15,2),@VVAL NUMERIC(15,2)
	BEGIN
	    
		IF @PADAT = 0 AND @PADDLESSPER = 0 
		  BEGIN
			SET @VCOSTDISC_FC =  @PCOSTDISC_FC 
			SET @VCOSTRATE_FC = @PCOSTRATE_FC
			SET @VCOSTAMT_FC = @PCOSTAMT_FC
		  END
		ELSE 
			BEGIN
			/*ADAT CALCULATION*/
			IF @PADAT <> 0 BEGIN
			   IF @PADAT < 0 BEGIN
				SET @VCOSTRATE_FC = ROUND(@PCOSTRATE_FC / ((100 - ABS(@PADAT)) / 100), 2)
				SET @VCOSTDISC_FC = ROUND( 100 - ((@VCOSTRATE_FC / @PRAPARATE) * 100) ,2)  
			   END /*IF*/
			  
			   IF @PADAT > 0 BEGIN
				SET @VCOSTRATE_FC = ROUND(@PCOSTRATE_FC * ((100 - ABS(@PADAT)) / 100), 2)
				SET @VCOSTDISC_FC = ROUND( 100 - ((@VCOSTRATE_FC / @PRAPARATE) * 100) ,2)           
			   END 
			 END
			
			/*addless percentage calculation*/
			IF @PADDLESSPER <> 0 
			  BEGIN
			     
				 /*SET @VCOSTDISC_FC =  @VCOSTDISC_FC + @PADDLESSPER*/
				 SET @VCOSTDISC_FC =  ISNULL(@VCOSTDISC_FC,@PCOSTDISC_FC)+ @PADDLESSPER
				 SET @VCOSTRATE_FC = ROUND((@PRAPARATE * (100-@VCOSTDISC_FC) )/100,2)  
				 SET @VCOSTAMT_FC = round(@VCOSTRATE_FC * @PCTS,2)
			  END /*IF*/
			ELSE
			  BEGIN
				SET @VCOSTAMT_FC = @PCOSTAMT_FC
			  END
			END		 
		END
	    
    IF @PTYPE = 'COSTRATE_FC' SET @VVAL=@VCOSTRATE_FC
	ELSE IF @PTYPE = 'COSTDISC_FC' SET @VVAL =@VCOSTDISC_FC
	ELSE IF @PTYPE = 'COSTAMT_FC' SET @VVAL =@VCOSTAMT_FC
	ELSE SET @VVAL = -1
    
    RETURN @VVAL
	
END
GO
/****** Object:  Table [dbo].[CLARITYMAS]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CLARITYMAS](
	[CLARITYCD] [numeric](5, 0) NOT NULL,
	[CLARITYNM] [varchar](20) NULL,
	[STATUS] [varchar](1) NULL,
	[ORD] [numeric](5, 0) NULL,
 CONSTRAINT [PK_CLARITYMAS_CLARITYCD] PRIMARY KEY CLUSTERED 
(
	[CLARITYCD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_CLARITYMAS_CLARITYNM] UNIQUE NONCLUSTERED 
(
	[CLARITYNM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[autoEmailSubScribers]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[autoEmailSubScribers](
	[emailid] [varchar](100) NULL,
	[registeredOn] [datetime] NULL,
	[status] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClientLoginHistory]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientLoginHistory](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[Clientcd] [int] NOT NULL,
	[CloginTime] [datetime] NULL,
	[CLogout] [char](1) NULL,
	[CLogoutTime] [datetime] NULL,
	[CSessionID] [varchar](100) NULL,
	[TRACKED_IP] [varchar](30) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CLIENTMASTERMAPPING]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTMASTERMAPPING](
	[MAPID] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[EXCEL_COLUMN] [nvarchar](50) NULL,
	[DB_COLUMN] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clientmaster]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clientmaster](
	[CLIENTCD] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Title] [varchar](5) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[birthdate] [datetime] NULL,
	[CompanyNm] [varchar](250) NULL,
	[Designation] [varchar](100) NULL,
	[Terms] [varchar](50) NULL,
	[creditdays] [numeric](5, 0) NULL,
	[Commission] [numeric](5, 2) NULL,
	[Brokerage] [numeric](5, 2) NULL,
	[PriceDiscount] [numeric](5, 2) NULL,
	[Discount] [numeric](5, 2) NULL,
	[PriceFormat] [char](10) NULL,
	[TaxDetails] [varchar](250) NULL,
	[ReferenceFrom] [varchar](150) NULL,
	[ReferenceThrough] [varchar](150) NULL,
	[Address] [varchar](250) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zipcode] [varchar](10) NULL,
	[Countrycd] [varchar](20) NULL,
	[Phone_Countrycd] [varchar](10) NULL,
	[Phone_STDcd] [varchar](10) NULL,
	[Phone_No] [varchar](20) NULL,
	[Phone_Countrycd2] [varchar](10) NULL,
	[Phone_STDCd2] [varchar](10) NULL,
	[Phone_No2] [varchar](20) NULL,
	[Fax_Countrycd] [varchar](10) NULL,
	[Fax_STDCd] [varchar](10) NULL,
	[Fax_No] [varchar](20) NULL,
	[Mobile_CountryCd] [varchar](10) NULL,
	[Mobile_No] [varchar](15) NULL,
	[EmailID1] [varchar](75) NULL,
	[EmailID2] [varchar](75) NULL,
	[EmailID3] [varchar](75) NULL,
	[all_emailid] [varchar](300) NULL,
	[Website] [varchar](100) NULL,
	[BusinessType] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [numeric](10, 0) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [numeric](10, 0) NULL,
	[ApproveStatus] [varchar](1) NULL,
	[ApproveStatusOn] [datetime] NULL,
	[ApproveStatusBy] [numeric](10, 0) NULL,
	[StatusUpdatedOn] [datetime] NULL,
	[StatusUpdatedBy] [numeric](10, 0) NULL,
	[status] [varchar](10) NULL,
	[WholeStockAccess] [varchar](1) NULL,
	[bankdetails] [varchar](4000) NULL,
	[routingdetails] [varchar](4000) NULL,
	[handle_location] [int] NULL,
	[smid] [int] NULL,
	[emailstatus] [varchar](10) NULL,
	[lastlogindate] [datetime] NULL,
	[skypeid] [varchar](100) NULL,
	[qqid] [varchar](100) NULL,
	[emailSubscr] [char](1) NULL,
	[emailSubscrDate] [datetime] NULL,
	[UTypeID] [int] NULL,
	[UserRights] [varchar](1) NULL,
 CONSTRAINT [PK_CM_CLIENTCD] PRIMARY KEY CLUSTERED 
(
	[CLIENTCD] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ClientLoginHistoryDetails]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientLoginHistoryDetails]
@ReturnVal int output,
@CLIENTCD int,
@CSessionID varchar(75),
@CLogID int,
@CAction char(1),
@LogTime datetime
As

BEGIN

DECLARE @CLoginTime datetime
DECLARE @CLogoutTime datetime
DECLARE @CLogout_s char(1)

SET @CLoginTime = GetDate()
SET @CLogoutTime = GetDate()
SET @CLogout_s='N'

SET NOCOUNT ON

IF @CAction = 'I'
BEGIN
	
	UPDATE ClientLoginHistory  SET CLogout = 'Y'  WHERE  clientcd = @clientcd
	
	INSERT INTO ClientLoginHistory (CLIENTCD, CLoginTime,CLogout, CSessionID)
	VALUES (@CLIENTCD, @LogTime,@CLogout_s, @CSessionID)
	
	UPDATE clientmaster set lastlogindate=@CLoginTime where clientcd = @clientcd
	SET @ReturnVal = @@Identity

END
ELSE IF @CAction = 'U'
BEGIN
	
	UPDATE ClientLoginHistory  SET CLogout = 'Y', CLogoutTime = @LogTime WHERE  clientcd = @clientcd AND  CSessionID = @CSessionID AND LogID =  @CLogID
	
	SET @ReturnVal = 0

END

SET NOCOUNT OFF

END
GO
/****** Object:  StoredProcedure [dbo].[ClientChangePassword]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	 UPDATE clientmaster SET Password = @NewPassword  WHERE LoginName= @LoginName
		SET @ReturnVal = 0
		END  
	ELSE BEGIN  
		SET @ReturnVal = 1  
	END
end;
GO
/****** Object:  StoredProcedure [dbo].[AppointmentStatusChange]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[AppointmentStatusChange]
@ReturnVal int output,
@AppId int,
@status char(1),
@UpdatedBy int
AS 
BEGIN

	Declare @StatusUpdatedOn datetime
	SET @StatusUpdatedOn = GetDate()

	Update Appointments SET status=@status, StatusUpdatedOn = @StatusUpdatedOn, UpdatedBy = @UpdatedBy WHERE AppID = @AppId

	SET @ReturnVal =0

END
GO
/****** Object:  StoredProcedure [dbo].[addUpdateColorMas]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addUpdateColorMas]    
@ReturnVal int output,    
@PPROCCD AS numeric(10),    
@PCOLORNM AS VARCHAR(100),    
@PSHORTNM AS VARCHAR(100),    
@PISFANCY AS CHAR,   
@PROCORD AS NUMERIC(10),
@PFLAG AS VARCHAR(30)
AS     
BEGIN    
 DECLARE @MAXPROCCD AS INTEGER    
 DECLARE @MAXORD AS INTEGER      
 BEGIN 
  IF UPPER(@PFLAG) = 'UPDATE'     
   BEGIN    
	IF EXISTS(SELECT * FROM procmas WHERE procgroup='COLOR' AND proccd = @PPROCCD)    
	BEGIN    
	 UPDATE [procmas]    
	 SET [procnm] = @PCOLORNM     
	  ,[shortnm]  = @PSHORTNM     
	  ,[fancy_color_status] =@PISFANCY       
	  ,[ord]=@PROCORD
	  WHERE procgroup='COLOR' AND proccd = @PPROCCD    
	   
	 SET @ReturnVal = 1  
	 RETURN  
	END     
   END       
  ELSE  
   BEGIN    
	IF NOT EXISTS(SELECT * FROM procmas WHERE procgroup='COLOR' AND PROCNM = @PCOLORNM)    
	 BEGIN  
	  SELECT @MAXPROCCD=MAX(PROCCD)+1 FROM procmas WHERE procgroup='COLOR'    
	  IF @PROCORD<>0 BEGIN 
			SET @MAXORD= @PROCORD
	  END ELSE BEGIN
		SELECT @MAXORD=MAX(ORD)+1 FROM procmas WHERE procgroup='COLOR'
	  END
	  INSERT INTO [procmas]    
	   ([procgroup],[proccd],[procnm],[shortnm],[ord],[status],[fancy_color_status] )  VALUES    
	   ('COLOR',@MAXPROCCD,@PCOLORNM,@PSHORTNM,@MAXORD,'Y',@PISFANCY)    
	   SET @ReturnVal = 0    
	   RETURN  
	 END  
	ELSE  
	 BEGIN  
	  SET @ReturnVal = 2  
	  RETURN  
	 END  
   END   
 END    
	  
 SET @ReturnVal = 2         
 Err_Handler:    
  SET @ReturnVal = -1    
	  
 CleanUp:    
  SET @ReturnVal = 0    
	
END
GO
/****** Object:  UserDefinedFunction [dbo].[adat_calc]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[adat_calc](  
@PADAT numeric(15,2),  
@paddlessper NUMERIC(5,2) ,  
@PRAPARATE numeric(15,2),  
@PASKRATE_FC numeric(15,2),  
@PASKDISC_FC numeric(15,2),  
@PASKAMT_FC numeric(15,2),  
@pcts numeric(15,2),  
@PTYPE varchar(50))  
RETURNS NUMERIC(15,2)  
AS  
BEGIN  
 DECLARE  
  @VASKRATE_FC NUMERIC(15,2),@VASKDISC_FC NUMERIC(15,2),@VASKAMT_FC NUMERIC(15,2),@VVAL NUMERIC(15,2),@VBID_LIMIT NUMERIC(6,2)
 BEGIN  
       
  IF @PADAT = 0 AND @PADDLESSPER = 0   
    BEGIN  
   SET @VASKDISC_FC =  @PASKDISC_FC   
   SET @VASKRATE_FC = @PASKRATE_FC  
   SET @VASKAMT_FC = @PASKAMT_FC  
    END  
  ELSE   
   BEGIN  
   /*ADAT CALCULATION*/  
   IF @PADAT <> 0 BEGIN  
      IF @PADAT < 0 BEGIN  
    SET @VASKRATE_FC = ROUND(@PASKRATE_FC / ((100 - ABS(@PADAT)) / 100), 2)  
    SET @VASKDISC_FC = ROUND( 100 - ((@VASKRATE_FC / @PRAPARATE) * 100) ,2)    
      END /*IF*/  
       
      IF @PADAT > 0 BEGIN  
    SET @VASKRATE_FC = ROUND(@PASKRATE_FC * ((100 - ABS(@PADAT)) / 100), 2)  
    SET @VASKDISC_FC = ROUND( 100 - ((@VASKRATE_FC / @PRAPARATE) * 100) ,2)             
      END /*IF*/  
    END /*IF*/  
           
   /*addless percentage calculation*/  
   IF @PADDLESSPER <> 0   
     BEGIN  
          
     /*SET @VASKDISC_FC =  @VASKDISC_FC + @PADDLESSPER*/  
    IF @PASKDISC_FC IS NULL   
     BEGIN  
      SET @VASKDISC_FC =  @PASKDISC_FC  
      SET @VASKRATE_FC = @PASKRATE_FC    
      SET @VASKAMT_FC = @PASKAMT_FC        
     END  
    ELSE  
     BEGIN  
      SET @VASKDISC_FC =  ISNULL(@VASKDISC_FC,@PASKDISC_FC)+ @PADDLESSPER  
      SET @VASKRATE_FC = ROUND((@PRAPARATE * (100-@VASKDISC_FC) )/100,2)    
      SET @VASKAMT_FC = round(@VASKRATE_FC * @PCTS,2)  
     END  
     END /*IF*/  
   ELSE  
     BEGIN  
    SET @VASKAMT_FC = @PASKAMT_FC  
     END  
   END     
  END  
      
    SELECT @VBID_LIMIT=ISNULL(BIDLIMITVALUE,0) FROM SETTINGS
      
    IF @PTYPE = 'ASKRATE_FC' SET @VVAL=@VASKRATE_FC  
 ELSE IF @PTYPE = 'ASKDISC_FC' SET @VVAL =@VASKDISC_FC  
 ELSE IF @PTYPE = 'ASKAMT_FC' SET @VVAL =@VASKAMT_FC  
 ELSE IF @PTYPE = 'MAXBIDDISC_FC' SET @VVAL =@VASKDISC_FC + @VBID_LIMIT
 ELSE SET @VVAL = -1  
      
    RETURN @VVAL  
   
END
GO
/****** Object:  StoredProcedure [dbo].[ClientStatusChange]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[ClientStatusChange]
@ReturnVal int output,
@CLIENTCD int,
@status char(1),
@UpdatedBy int
AS 
BEGIN

	Declare @StatusUpdatedOn datetime
	SET @StatusUpdatedOn = GetDate()

	Update ClientMaster SET status=@status, StatusUpdatedOn = @StatusUpdatedOn, StatusUpdatedBy = @UpdatedBy WHERE CLIENTCD = @CLIENTCD

	SET @ReturnVal =0

END
GO
/****** Object:  StoredProcedure [dbo].[ClientPassword_Change]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClientPassword_Change]
@ReturnVal int output,
@clientcd int,
@OldPassword varchar(100),
@NewPassword varchar(100)
AS 
Declare @UpdatedOn datetime
SET @UpdatedOn = GetDate()

IF exists(SELECT clientcd FROM clientmaster WHERE Password = @OldPassword AND clientcd = @clientcd )
BEGIN
	
	UPDATE clientmaster SET Password = @NewPassword  WHERE clientcd= @clientcd

	SET @ReturnVal = 0

END
ELSE
BEGIN

	SET @ReturnVal = 1

END
GO
/****** Object:  StoredProcedure [dbo].[EventProcMas]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EventProcMas]    
@ReturnVal int output, 
@PPROCGROUP AS VARCHAR(60),   
@PPROCCD AS numeric(10)=NULL,   
@PPROCNM AS VARCHAR(100),   
@PSHORTNM AS VARCHAR(100), 
@PROCORD AS NUMERIC(10),
@PFLAG AS VARCHAR(30)
AS     
BEGIN    
	DECLARE @MAXPROCCD AS INTEGER    
	DECLARE @MAXORD AS INTEGER
 
	IF UPPER(@PFLAG) = 'UPDATE' BEGIN    
		IF EXISTS(SELECT * FROM [DBO].procmas WHERE procgroup=@PPROCGROUP AND proccd = @PPROCCD) BEGIN    
	 		UPDATE [DBO].[procmas] SET [procnm] = @PPROCNM,[shortnm] = @PSHORTNM, [ord] = @PROCORD
	 		WHERE procgroup=@PPROCGROUP AND proccd = @PPROCCD    
	 		SET @ReturnVal = 1  
	 		RETURN
	 	END ELSE BEGIN
	 		SET @ReturnVal = -1
			RETURN  
		END     
	END       
	ELSE IF UPPER(@PFLAG) = 'INSERT' BEGIN 
		IF NOT EXISTS(SELECT * FROM [DBO].procmas WHERE procgroup=@PPROCGROUP AND PROCNM = @PPROCNM) BEGIN  
  			SELECT @MAXPROCCD=MAX(PROCCD)+1 FROM procmas WHERE procgroup=@PPROCGROUP    
			IF @PROCORD<>0 BEGIN 
				SET @MAXORD= @PROCORD
			END ELSE BEGIN
				SELECT @MAXORD=MAX(ORD)+1 FROM procmas WHERE procgroup=@PPROCGROUP
			END  
  			INSERT INTO [DBO].[procmas]    
  			([procgroup],[proccd],[procnm],[shortnm],[ord],[status],[fancy_color_status] )  VALUES    
  			(@PPROCGROUP,@MAXPROCCD,@PPROCNM,@PSHORTNM,@MAXORD,'Y',null)    
			SET @ReturnVal = 0  
			RETURN  
		END ELSE BEGIN
			SET @ReturnVal = 3  
			RETURN  
		END
	END ELSE IF UPPER(@PFLAG) = 'DELETE' BEGIN 
		IF EXISTS(SELECT * FROM [DBO].procmas WHERE procgroup=@PPROCGROUP AND PROCNM = @PPROCNM) BEGIN  
  			DELETE FROM [DBO].[procmas] WHERE procgroup=@PPROCGROUP AND proccd = @PPROCCD AND PROCNM=@PPROCNM
			SET @ReturnVal = 2  
			RETURN  
		END ELSE BEGIN
			SET @ReturnVal = -1
			RETURN  
		END  
	END ELSE BEGIN  
		SET @ReturnVal = 3 
		RETURN  
	END  
	
	SET @ReturnVal = 3         
	Err_Handler:    
	SET @ReturnVal = -1    
		  
	CleanUp:    
	SET @ReturnVal = 0
	
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[delete_quotemas]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_quotemas]
@ReturnVal int output
AS
BEGIN
	DECLARE
		@SYSDATE DATETIME
	BEGIN
	    SELECT @SYSDATE = GETDATE()
        BEGIN
			UPDATE QUOTEMAS SET STATUS='O' where qm_delete_date <= @SYSDATE AND STATUS='P'
		IF @@error <> 0 goto Err_Handler
		SET @ReturnVal = 0
		
		Err_Handler:
			SET @ReturnVal = -1
				
		CleanUp:
			SET @ReturnVal = 0

		END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[delete_ClientMaster]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[delete_ClientMaster]
@ReturnVal int output,
@clientcd numeric(10)
AS 
BEGIN

	BEGIN
		delete from clientmaster
		where clientcd=@clientcd
		
			
		SET @ReturnVal = 0
		
		IF @@error <> 0 goto Err_Handler
		
		SET @ReturnVal = 0
		
		Err_Handler:
			SET @ReturnVal = -1
		
		
		CleanUp:
			SET @ReturnVal = 0

	END

END
GO
/****** Object:  UserDefinedFunction [dbo].[GET_RAPA_SIZE]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GET_RAPA_SIZE](@pcts numeric(15,2))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  SIZENM FROM RAPAPORT_SIZE_ORG WHERE @pcts BETWEEN FSIZE AND TSIZE )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GET_FANCY_COLOR_STATUS]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GET_FANCY_COLOR_STATUS](@pcolor VARCHAR(100))
RETURNS CHAR
AS
	BEGIN
  RETURN (select fancy_color_status FROM  procmas WHERE procgroup='COLOR' and procnm=@pcolor)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GET_EXCEL_ERRORLIST]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GET_EXCEL_ERRORLIST]() RETURNS TABLE
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
GO
/****** Object:  UserDefinedFunction [dbo].[getclientname]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getclientname](@pclientcd numeric(10))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select loginname + ' (' + isnull(companynm,'.') + ')' as loginname from clientmaster where clientcd=@pclientcd)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getclientcdbyloginname]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getclientcdbyloginname](@ploginname numeric(10))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select clientcd from clientmaster where upper(loginname)=upper(@ploginname))
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getclient_deactivate_days]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getclient_deactivate_days](@pval VARCHAR(255),@pprocgroup VARCHAR(255)	)
RETURNS INT
AS
	BEGIN
  RETURN (select  client_deactivate_days FROM settings )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetClientPassword]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetClientPassword](@EmailId varchar(60)) returns varchar(30)
as
begin
	declare @password varchar(30);
	select @password=password from clientmaster where loginname = @Emailid;
	return @password;
end;
GO
/****** Object:  UserDefinedFunction [dbo].[GetHandleLocationByLoginName]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetHandleLocationByLoginName](@LoginName varchar(60),@Handle_Location varchar(30)) returns nvarchar(max) as  
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
GO
/****** Object:  UserDefinedFunction [dbo].[getprocvalbytype]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getprocvalbytype](@pval VARCHAR(255),@pprocgroup VARCHAR(255),@pfromtype varchar(255),@ptotype varchar(255)	)
RETURNS VARCHAR(100)
AS
	BEGIN
    if @pfromtype = 'PROCNM' begin
        if @ptotype = 'ORD' begin
			RETURN (select  ORD FROM dbo.PROCMAS WHERE procnm=@pval and procgroup = @pprocgroup)
		end
		if @ptotype = 'SHORTNM' begin
			RETURN (select  SHORTNM FROM dbo.PROCMAS WHERE procnm=@pval and procgroup = @pprocgroup)
		end
    end
		
    if @pfromtype = 'SHORTNM' begin
        if @ptotype = 'ORD' begin
			RETURN (select  ORD FROM dbo.PROCMAS WHERE shortnm=@pval and procgroup = @pprocgroup)
		end
		if @ptotype = 'PROCNM' begin
			RETURN (select procnm FROM dbo.PROCMAS WHERE shortnm=@pval and procgroup = @pprocgroup)
		end
    end
    return 'err'
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getprocord]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getprocord](@pval VARCHAR(255),@pprocgroup VARCHAR(255)	)
RETURNS INT
AS
	BEGIN
  RETURN (select  right(replicate('0',5) + cast(ORD as varchar(50)),5) FROM dbo.PROCMAS WHERE procnm=@pval and procgroup = @pprocgroup)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getprocnmbyshortnm]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getprocnmbyshortnm](@pval VARCHAR(255),@pprocgroup VARCHAR(255)	)
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  procnm FROM PROCMAS WHERE shortnm=@pval and procgroup = @pprocgroup)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getprocnm]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getprocnm](@pval VARCHAR(255),@pprocgroup VARCHAR(255))
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @VALOUT VARCHAR(30);
	IF @pval = ''
		BEGIN 
			SELECT @VALOUT=''
		END 
	ELSE
		BEGIN
			select  @VALOUT =procnm FROM dbo.PROCMAS WHERE ord=@pval and procgroup = @pprocgroup
		END
		
		RETURN @VALOUT
END
GO
/****** Object:  UserDefinedFunction [dbo].[getordsize]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getordsize](@ppcs numeric(10),@pcts numeric(10,3))
RETURNS INT
AS
	BEGIN
  RETURN (select ordsize from DBO.RAPAPORT_SIZE_ORG where @pcts between fsize and tsize)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GETORDORGCOLOR]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GETORDORGCOLOR](@PCOLOR VARCHAR(100),@PTYPE VARCHAR(100)) 
RETURNS INTEGER 
AS 
BEGIN
	DECLARE 
		@VVALUE INTEGER;
	IF @PTYPE = 'MIN' 
		SET @VVALUE =(SELECT MIN(ORD) FROM PROCMAS WHERE PROCGROUP='COLOR' AND DBO.GETORGPARAM(PROCNM) = UPPER(@PCOLOR))
	ELSE
		SET @VVALUE = (SELECT MAX(ORD)FROM PROCMAS WHERE PROCGROUP='COLOR' AND DBO.GETORGPARAM(PROCNM) = UPPER(@PCOLOR))
	
	RETURN @VVALUE
END
GO
/****** Object:  UserDefinedFunction [dbo].[GETORDORGCLARITY]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GETORDORGCLARITY](@PCLARITY VARCHAR(100),@PTYPE VARCHAR(100)) 
RETURNS INTEGER 
AS 
BEGIN
	DECLARE 
		@VVALUE INTEGER;
	IF @PTYPE = 'MIN' 
		SET @VVALUE =(SELECT MIN(ORD) FROM PROCMAS WHERE PROCGROUP='CLARITY' AND DBO.GETORGPARAM(PROCNM) = UPPER(@PCLARITY))
	ELSE
		SET @VVALUE = (SELECT MAX(ORD)FROM PROCMAS WHERE PROCGROUP='CLARITY' AND DBO.GETORGPARAM(PROCNM) = UPPER(@PCLARITY))
	
	RETURN @VVALUE
END
GO
/****** Object:  UserDefinedFunction [dbo].[getnewarrivalstatus]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getnewarrivalstatus](@pcurdate DATETIME)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE
		@VNEW_ARRIVAL_DAYS NUMERIC(5),@VDATE DATETIME,@SYSDATE DATETIME
	BEGIN
		SELECT @VNEW_ARRIVAL_DAYS= NEW_ARRIVAL_DAYS FROM DBO.SETTINGS
	    SELECT @VDATE = (GETDATE() - @VNEW_ARRIVAL_DAYS)
	    SELECT @SYSDATE = GETDATE()
        
        IF @PCURDATE BETWEEN @VDATE AND @SYSDATE BEGIN
           RETURN 'N'
        END
        ELSE
        BEGIN
          RETURN '-'
        END  
	END
	RETURN '-'
END
GO
/****** Object:  UserDefinedFunction [dbo].[getusertype]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getusertype](@pval VARCHAR(255))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  UserDesc FROM UserTypeMaster WHERE UTypeID=@pval )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getusernm]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getusernm](@pval VARCHAR(255))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  UserName FROM usermas WHERE UserCd=@pval )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getuseremail]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getuseremail](@pval VARCHAR(255))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  emailid FROM usermas WHERE UserCd=@pval )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getsortcode]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getsortcode](@psortnm VARCHAR)
RETURNS numeric(10)
AS
	BEGIN
  RETURN (select  sort_code FROM dbo.sorting_mas WHERE sort_nm=upper(@psortnm) )
	END
GO
/****** Object:  StoredProcedure [dbo].[Insert_datalolg]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insert into datalog(curdate,description) values (GetDate(),'hello welcome');
--select * from datalog
--exec  dbo.Insert_datalolg @returnval='0',@Description='Hello Testing'
CREATE PROCEDURE [dbo].[Insert_datalolg]
@ReturnVal int output,
@Description varchar(4000)
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

	BEGIN
		insert into datalog(curdate,description) values (@SavedOn,@Description)
	END   
END
GO
/****** Object:  StoredProcedure [dbo].[insert_clientmastermapping]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_clientmastermapping]
@ReturnVal int output,
@excel_column varchar(100),
@db_column varchar(100)
AS 
BEGIN

Declare @SavedOn datetime
DECLARE @TOTCNT numeric(10)

SET @SavedOn = GetDate()

		BEGIN
			select @TOTCNT= count(1) from CLIENTMASTERMAPPING where db_column=@db_column
			
			
			IF @TOTCNT = 0
			BEGIN
				INSERT INTO CLIENTMASTERMAPPING(excel_column,db_column) 
				values(@excel_column,@db_column)
					
				SET @ReturnVal = 0
			END
			ELSE
			BEGIN
				SET @ReturnVal = -2
			END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_ClientMaster_old]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Insert_ClientMaster_old]
@ReturnVal int output,
@LoginName varchar(100) ,
@Password varchar(100) ,
@Title varchar(5) ,
@FirstName varchar(50) ,
@LastName varchar(50) ,
@birthdate datetime ,
@CompanyNm varchar(250) ,
@Designation varchar(100) ,
@ReferenceThrough varchar(150) ,
@Address varchar(250) ,
@City varchar(50) ,
@State varchar(50) ,
@Zipcode varchar(10) ,
@Countrycd varchar(20) ,
@Phone_Countrycd varchar(10) ,
@Phone_STDcd varchar(10) ,
@Phone_No varchar(100) ,
@Phone_Countrycd2 varchar(10) ,
@Phone_STDCd2 varchar(10) ,
@Phone_No2 varchar(100) ,
@Fax_Countrycd varchar(10) ,
@Fax_STDCd varchar(10) ,
@Fax_No varchar(20) ,
@Mobile_CountryCd varchar(10) ,
@Mobile_No varchar(100) ,
@EmailID1 varchar(75) ,
@EmailID2 varchar(75) ,
@EmailID3 varchar(75) ,
@all_emailid varchar(300),
@Website varchar(100) ,
@BusinessType varchar(150) ,
@CreatedBy numeric(10),
@status varchar(10),
@bankdetails varchar(4000),
@routingdetails varchar(4000),
@SkypeId varchar(100),
@QQId varchar(100)
AS 
BEGIN
Declare @SavedOn datetime
SET @SavedOn = GetDate()
 	SELECT CLIENTCD FROM CLIENTMASTER WHERE loginname = @loginname
	IF @@RowCount >= 1	
		BEGIN
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
						   bankdetails,routingdetails,skypeid,qqid) 
			values(@LoginName,@Password,@Title,@FirstName,@LastName,
				   @birthdate,@CompanyNm,@Designation,
				   @ReferenceThrough,@Address,@City,@State,@Zipcode,@Countrycd,@Phone_Countrycd,
				   @Phone_STDcd,@Phone_No,@Phone_Countrycd2,@Phone_STDCd2,@Phone_No2,@Fax_Countrycd,
				   @Fax_STDCd,@Fax_No,@Mobile_CountryCd,@Mobile_No,@EmailID1,@EmailID2,@EmailID3,@all_emailid,
						   @Website,@BusinessType,@savedon,@CreatedBy,@status,
						   @bankdetails,@routingdetails,@SkypeId,@QQId)
				
			SET @ReturnVal = 0
		
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1			
			
			CleanUp:
				SET @ReturnVal = 0
		END
	    
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_ClientMaster]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_ClientMaster]    
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
@utypeid int =null   
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
GO
/****** Object:  StoredProcedure [dbo].[insert_appointments]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_appointments]  
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
GO
/****** Object:  StoredProcedure [dbo].[insert_guestmaster]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_guestmaster]
@ReturnVal int output,
@FirstNm varchar(50),
@LastNm varchar(50),
@EmailId varchar(200),
@Phone_Countrycd varchar(10),
@Phone_STDcd varchar(10),
@Phone_No varchar(30),
@Mobile_No varchar(30),
@CompanyNm varchar(100)
AS 
BEGIN

Declare @CreatedOn datetime
Declare @LastLoginTime datetime
DECLARE @COUNTLOGS INTEGER

SET @CreatedOn = GetDate()
SET @LastLoginTime = GetDate()

	BEGIN
		IF EXISTS (SELECT EMAILID FROM GUESTMASTER WHERE EMAILID=@EMAILID)
			BEGIN
				SELECT @COUNTLOGS= COUNTLOGS + 1 FROM GUESTMASTER WHERE EMAILID=@EMAILID 
				UPDATE GUESTMASTER 
				SET LASTLOGINTIME = @LASTLOGINTIME,
					COUNTLOGS = @COUNTLOGS,
					COMPANYNM = @CompanyNm,
					PHONE_COUNTRYCD = @PHONE_COUNTRYCD,
					PHONE_STDCD = @PHONE_STDCD,
					PHONE_NO = @PHONE_NO,
					MOBILE_NO = @Mobile_No,
					FIRSTNM = @FirstNm,
					LASTNM = @LastNm
				WHERE EMAILID=@EMAILID 
				
				SET @RETURNVAL = 0
			END
		ELSE
			BEGIN
				INSERT INTO guestmaster(FirstNm,LastNm,CompanyNm,EmailID,Phone_Countrycd,Phone_STDcd,Phone_No,Mobile_No,CreatedOn,LastLogInTime,CountLogs,isdeleted) 
				values(@FirstNm, @LastNm, @CompanyNm, @emailid, @Phone_Countrycd, @Phone_STDcd,@Phone_No,@Mobile_No, @CreatedOn, @LastLoginTime,1,'Y')
					
				SET @ReturnVal = 0
			END
			IF @@error <> 0 goto Err_Handler
		
			SET @ReturnVal = 0
		
			Err_Handler:
				SET @ReturnVal = -1
				
			CleanUp:
				SET @ReturnVal = 0
	END
		
END
GO
/****** Object:  StoredProcedure [dbo].[insert_dsSubscriber]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_dsSubscriber]
--daily stock updates
@ReturnVal int output,
@pEmailid varchar(100)
AS
BEGIN
	Declare @SavedOn datetime
	SET @SavedOn = getdate()
	
	BEGIN
		if not exists (SELECT emailid FROM autoEmailSubScribers WHERE emailid= @pEmailid)
			begin 
				INSERT INTO autoEmailSubScribers(emailid,registeredOn,status) VALUES(@pEmailid ,@SavedOn,'Y')
				SET @ReturnVal = 0
			end
		else 
			goto Err_Handler

		IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			CleanUp:
				SET @ReturnVal = 0
		
	END 

END
GO
/****** Object:  StoredProcedure [dbo].[insert_ORDSET]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_ORDSET]
@ReturnVal int output,
@CLIENTCD numeric(10),
@FORD1 VARCHAR(200),
@FORD2 VARCHAR(200),
@FORD3 VARCHAR(200),
@FORD4 VARCHAR(200),
@FORD5 VARCHAR(200),
@FORD6 VARCHAR(200),
@type varchar(20),
@uid numeric(10)
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

		BEGIN
		    delete from dbo.ordset where clientcd=@CLIENTCD
			
			INSERT INTO dbo.ORDSET(CLIENTCD,FORD1,FORD2,FORD3,FORD4,FORD5,FORD6,type,uid) 
			values(@CLIENTCD,@FORD1,@FORD2,@FORD3,@FORD4,@FORD5,@FORD6,@type,@uid)
				
			SET @ReturnVal = 0
		
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			
			CleanUp:
				SET @ReturnVal = 0
		END    
END
GO
/****** Object:  Table [dbo].[MyWatchlist]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MyWatchlist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[clientcd] [int] NULL,
	[curdate] [datetime] NULL,
	[watchlistname] [varchar](1000) NULL,
	[watchlistqry] [varchar](1000) NULL,
	[watchlistorder] [varchar](1000) NULL,
	[pagesize] [numeric](5, 0) NULL,
	[validdays] [numeric](5, 0) NULL,
	[status] [varchar](2) NULL,
	[UpdatedBy] [numeric](5, 0) NULL,
	[StatusUpdatedOn] [datetime] NULL,
	[completedate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[MyDivide]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[MyDivide](@pone numeric(10,3),@ptwo numeric(10,3),@pdec numeric(10))
RETURNS INT
AS
BEGIN
  if DBO.nvl (@ptwo,0) = 0 BEGIN
    return 0 ;
  END
  ELSE
  BEGIN
   return round (@pone/@ptwo,@pdec) ;
  END
  
  RETURN 0;
  
END
GO
/****** Object:  UserDefinedFunction [dbo].[isSeller]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[isSeller](@pLoginName nvarchar(60)) returns char
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
GO
/****** Object:  UserDefinedFunction [dbo].[isallowedtowatch]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[isallowedtowatch](@pclientcd varchar(20) ,@pusercd VARCHAR(20))
RETURNS VARCHAR(100)
AS
	
	BEGIN
		DECLARE @putypeid varchar(20),@pusercountry numeric(5),@pclientcountry numeric(5),@psmid numeric(5)
		
		select @pclientcountry = handle_location,@psmid=smid from dbo.clientmaster where clientcd = @pclientcd 
		select @pusercountry = countryId,@putypeid=utypeid from dbo.usermas where usercd=@pusercd 
		if @putypeid = 1 
		begin
		  return 'Y'
		end
		if @putypeid = 2
		begin
		  if @pclientcountry = @pusercountry 
			begin
				return 'Y'
			end
		  else
		    begin
		        return 'N'
		    end
		  
		end
		if @putypeid =3 
		begin
		   if @pusercd = @psmid begin
		      return 'Y'
		   END
		   else
		     BEGIN
			  return 'N'   
			  END
		   end
		
		RETURN 'N'
		end
GO
/****** Object:  StoredProcedure [dbo].[INSERT_USERSEARCHHISTORY]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_USERSEARCHHISTORY] 
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
GO
/****** Object:  StoredProcedure [dbo].[insert_Ticketmas]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_Ticketmas]
@ReturnVal int output,
@PersonName varchar(100),
@emailid varchar(200),
@contact1 varchar(100),
@countrycd numeric(5),
@remarks varchar(4000),
@status varchar(2)
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

 	
		BEGIN
			
			INSERT INTO Ticketmas(PersonName,emailid,contact1,countrycd,remarks,status,curdate) 
			values(@PersonName,@emailid,@contact1,@countrycd,@remarks,@status,@SavedOn)
				
			SET @ReturnVal = 0
		
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			
			CleanUp:
				SET @ReturnVal = 0
		END
END
GO
/****** Object:  Table [dbo].[quotedet]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[quotedet](
	[quoteid] [numeric](10, 0) NOT NULL,
	[cid] [numeric](10, 0) NULL,
	[stoneid] [varchar](50) NOT NULL,
	[qd_offerrate] [numeric](10, 2) NULL,
	[qd_offerdisc] [numeric](5, 2) NULL,
	[qd_rej_status] [varchar](50) NULL,
 CONSTRAINT [pk_quotedet_Qid_stoneid] PRIMARY KEY CLUSTERED 
(
	[quoteid] ASC,
	[stoneid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[SC_Id] [int] IDENTITY(1,1) NOT NULL,
	[SC_stoneid] [varchar](50) NULL,
	[SC_Clientcd] [int] NULL,
	[SC_Status] [varchar](50) NULL,
	[SC_Date] [datetime] NULL,
	[SC_MemoDate] [datetime] NULL,
	[SC_delete_date] [datetime] NULL,
	[sc_offerrate] [numeric](15, 2) NULL,
	[sc_offerdisc] [numeric](5, 2) NULL,
	[sc_rej_status] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[insert_SearchQry]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_SearchQry]
	@ReturnVal int output,
	@sid int output,
	@SearchQry varchar(5000)
	AS 
	BEGIN

	Declare @SavedOn datetime

	SET @SavedOn = GetDate()
		
		BEGIN
			
			INSERT INTO dbo.SearchQry(SearchQry) 
			values(@SearchQry)
			SET @SID= SCOPE_IDENTITY();	
			SET @ReturnVal = 0
			
			
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			
			CleanUp:
				SET @ReturnVal = 0

		END

	END
GO
/****** Object:  StoredProcedure [dbo].[insert_searchhistory]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_searchhistory]  
 @ReturnVal int output,  
 @sid int output,  
 @SearchName varchar(100),  
 @CID int,  
 @SHAPE varchar(1000),  
 @FCTS varchar(20),  
 @TCTS varchar(20),  
 @FCOLOR varchar(20),  
 @TCOLOR varchar(20),  
 @FCLARITY varchar(20),  
 @TCLARITY varchar(20),  
 @FPOLISH varchar(1000),  
 @FSYM varchar(1000),  
 @FFL varchar(1000),  
 @CERT VARCHAR(1000),  
 @FRATE varchar(20),  
 @TRATE varchar(20),  
 @FDISCPER varchar(20),  
 @TDISCPER varchar(20),  
 @FAMT varchar(20),  
 @TAMT varchar(20),  
 @FINCLUSION varchar(1000),  
 @FSTONEID varchar(120),  
 @CERTNO varchar(120),  
 @FTABLEPER varchar(20),  
 @TTABLEPER varchar(20),  
 @FDEPTHPER varchar(20),  
 @TDEPTHPER varchar(20),  
 @FGIRDLEPER varchar(20),  
 @TGIRDLEPER varchar(20),  
 @FORD1 VARCHAR(200),  
 @FORD2 VARCHAR(200),  
 @FORD3 VARCHAR(200),  
 @FORD4 VARCHAR(200),  
 @FORD5 VARCHAR(200),  
 @FORD6 VARCHAR(200),  
 @FCUT VARCHAR(200)=null,  
 @TCUT VARCHAR(200)=null,  
 @PAGESIZE VARCHAR(20),  
 @flengthmm varchar(100),  
 @tlengthmm varchar(100),  
 @fwidthmm varchar(100),  
 @twidthmm varchar(100),  
 @fdepthmm varchar(100),  
 @tdepthmm varchar(100),  
 @location varchar(100),  
 @flcolor varchar(100),  
 @culet varchar(100),  
 @auto varchar(1),  
 @fratiomm varchar(100),  
 @tratiomm varchar(100),  
 @nastatus varchar(10),  
 @omstatus varchar(10),  
 @avstatus varchar(10),  
 @type varchar(20),  
 @uid numeric(10),  
 @showonly varchar(12),  
 @isFancy char ,
 @MColor varchar(max)=null,
 @MClarity varchar(max)=null,
 @MCut varchar(max)=null
 AS   
 BEGIN  
  
 Declare @SavedOn datetime  
  
 SET @SavedOn = GetDate()  
  
   SELECT SID FROM SearchHistory WHERE CID = @CID  
    
  IF @@RowCount >= 10000000  
     
  BEGIN  
      
   SET @ReturnVal = 1  
  
  END  
  ELSE  
  BEGIN  
     
   INSERT INTO SearchHistory(searchname,cid,shape,fcts,tcts,  
   fcolor,tcolor,fclarity,tclarity,savedon ,  
   FPOLISH,FSYM,FFL,CERT,FRATE,TRATE,FDISCPER,TDISCPER,  
   FAMT,TAMT,FINCLUSION,FSTONEID,CERTNO,FTABLEPER,TTABLEPER,  
   FDEPTHPER,TDEPTHPER,FGIRDLEPER,TGIRDLEPER ,  
   ford1,ford2,ford3,ford4,ford5,ford6,  
   fcut,tcut,pagesize,  
   flengthmm,tlengthmm,fwidthmm,twidthmm,fdepthmm,tdepthmm,location,flcolor,culet,  
   AUTO,  
   fratiomm,tratiomm,  
   nastatus,omstatus,avstatus,type,uid,showonly,isfancy,MCOLOR,MCLARITY,MCUT )   
   values(@searchname,@cid,@shape,@fcts,@tcts,  
   @fcolor,@tcolor,@fclarity,@tclarity,@savedon,  
   @FPOLISH,@FSYM,@FFL,@CERT,@FRATE,@TRATE,@FDISCPER,@TDISCPER,  
   @FAMT,@TAMT,@FINCLUSION,@FSTONEID,@CERTNO,@FTABLEPER,@TTABLEPER,  
   @FDEPTHPER,@TDEPTHPER,@FGIRDLEPER,@TGIRDLEPER,  
   @ford1,@ford2,@ford3,@ford4,@ford5,@ford6,  
   @fcut,@tcut,@pagesize,  
   @flengthmm,@tlengthmm,@fwidthmm,@twidthmm,@fdepthmm,@tdepthmm,@location,@flcolor,@culet,  
   @AUTO,  
   @fratiomm,@tratiomm,  
   @nastatus,@omstatus,@avstatus,@type,@uid,@showonly,@isFancy,@MColor,@MClarity,@MCut 
   )  
   SET @SID= SCOPE_IDENTITY();   
   SET @ReturnVal = 0  
     
     
   IF @@error <> 0 goto Err_Handler  
     
   SET @ReturnVal = 0  
     
   Err_Handler:  
    SET @ReturnVal = -1  
     
     
   CleanUp:  
    SET @ReturnVal = 0  
  
  END  
  
 END
GO
/****** Object:  StoredProcedure [dbo].[insert_quotemas]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_quotemas]
@ReturnVal int output,
@cid numeric(10),
@sid int output
AS 
BEGIN
Declare @SavedOn datetime
SET @SavedOn = GetDate()
		BEGIN
			DECLARE @QM_DELETE_DATE datetime
			SELECT @QM_DELETE_DATE=GETDATE() + QM_DELETE_DAYS FROM SETTINGS
		END
		BEGIN
			BEGIN
				INSERT INTO quotemas(cid,curdate,status,completedate,qm_delete_date) 
				values(@cid,@savedon,'P',NULL,@QM_DELETE_DATE)
					
				SET @ReturnVal = 0
				SET @SID= SCOPE_IDENTITY();	
			END
		
		IF @@error <> 0 goto Err_Handler
			Err_Handler:
				SET @ReturnVal = -1
		
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_excel_validator]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_excel_validator]
as
WITH CTE AS(
SELECT RNO,
 CASE WHEN OUTSHAPE='' THEN ''ELSE 'SHAPE:' + OUTSHAPE  END +
 CASE WHEN OUTCTS='' THEN ''ELSE 'WEIGHT:' + OUTCTS END +
 CASE WHEN OUTCOLOR='' THEN ''ELSE 'COLOR:' + OUTCOLOR END +
 CASE WHEN OUTCLARITY='' THEN ''ELSE 'CLARITY:' + OUTCLARITY END +
 CASE WHEN OUTCUT='' THEN ''ELSE 'CUT:' + OUTCUT END +
 CASE WHEN OUTPOLISH='' THEN ''ELSE 'POLISH:' + OUTPOLISH END +
 CASE WHEN OUTSYM='' THEN ''ELSE 'SYM:' + OUTSYM END +
 CASE WHEN OUTFL='' THEN ''ELSE 'FLOUR.:' + OUTFL END +
 CASE WHEN OUTFL_COLOR='' THEN ''ELSE 'FL.COLOR:' + OUTFL_COLOR END +
 CASE WHEN OUTGIRDLE='' THEN ''ELSE 'GIRDLE:' + OUTGIRDLE END +
 CASE WHEN OUTCERT='' THEN ''ELSE 'LAB:' + OUTCERT END +
 CASE WHEN OUTLOCATION='' THEN '' ELSE 'LOCATION:' + OUTLOCATION END AS RESROW FROM (
SELECT RNO,CASE WHEN PSHAPE IS NULL THEN ISNULL(SHAPE,'') ELSE '' END OUTSHAPE,
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
  CASE WHEN ISNUMERIC(ISNULL(CTS,0))=0 THEN CONVERT(VARCHAR,CTS) ELSE '' END OUTCTS
  /*GIRDLEPER,
  DEPTH,DIA,DIATABLE,LENGTH,WIDTH,HEIGHT,PAVILION,PAVANGLE,PAVHEIGHT,CROWN,CROWNANGLE,CROWNHEIGHT,RATIO,STAR_LENGTH,LOWER_HALF,
  RAPARATE,RAPAAMT,ASKRATE_FC,ASKAMT_FC,ASKDISC_FC,COSTRATE_FC,COSTAMT_FC,COSTDISC_FC*/
  FROM (
--AS RES FROM (
--SELECT * FROM(
SELECT ROW_NUMBER() OVER(ORDER BY STONEID ) AS RNO,
COMPCD,STONEID,SHAPE,CTS,COLOR,CLARITY,CUT,POLISH,SYM,FLOURENCE,FL_COLOR,INCLUSION,HA,LUSTER,GIRDLE,GIRDLE_CONDITION,
CULET,MILKY,SHADE,NATTS,NATURAL,DEPTH,DIATABLE,LENGTH,WIDTH,CROWN,CROWNANGLE,CROWNHEIGHT,PAVILION,PAVANGLE,PAVHEIGHT,
MEASUREMENT,RATIO,PAIR,STAR_LENGTH,LOWER_HALF,KEY_TO_SYMBOL,REPORT_COMMENT,CERTIFICATE,CERTNO,RAPARATE,RAPAAMT,CURDATE,LOCATION,
LEGEND1,LEGEND2,LEGEND3,ASKRATE_FC,ASKDISC_FC,ASKAMT_FC,COSTRATE_FC,COSTDISC_FC,DIA,COLORDESC,BARCODE,INSCRIPTION,
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
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTLOGINHISTORY]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CLIENTLOGINHISTORY]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_appointments]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[spColorMas_Event]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[update_guestmaster]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_guestmaster]
@ReturnVal int output,
@CompanyName varchar(100),
@PersonName varchar(100),
@emailid varchar(200),
@Phone_Countrycd varchar(100),
@Phone_STDcd varchar(100),
@Phone_No varchar(200)
AS 
BEGIN
Declare @LastLoginTime datetime
Declare @CountLogs Integer
SET @LastLoginTime = GetDate()
SELECT @CountLogs= COUNTLOGS + 1 FROM guestmaster WHERE EmailID=@emailid 
	BEGIN
		UPDATE guestmaster SET LastLoginTime = @LastLoginTime,
								COUNTLOGS = @CountLogs,
								companynm = @CompanyName,
								phone_countrycd = @Phone_Countrycd,
								phone_stdcd = @Phone_STDcd,
								phone_no = @Phone_No
								WHERE EmailID=@emailid 
		SET @ReturnVal = 0
		IF @@error <> 0 goto Err_Handler
		SET @ReturnVal = 0
		Err_Handler:
			SET @ReturnVal = -1
		CleanUp:
			SET @ReturnVal = 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[update_ClientMasterByClient]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_ClientMasterByClient]
@ReturnVal int output,
@clientcd numeric(10),
@birthdate datetime=null ,
@Designation varchar(100)=null  ,
@Address varchar(250) =null ,
@City varchar(50) =null ,
@Countrycd varchar(20) =null ,
@BusinessType varchar(150) =null ,
@UpdatedBy numeric(10)=null ,
@WholeStockAccess varchar(1)=null 
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

 	
	BEGIN
		update clientmaster set 
		birthdate=@birthdate,Designation=@Designation,
		Address=@Address,City=@City,Countrycd=@Countrycd,
		BusinessType=@BusinessType,UpdatedOn=@SavedOn,UpdatedBy=@UpdatedBy
		where clientcd=@clientcd
		
			
		SET @ReturnVal = 0
		
		IF @@error <> 0 goto Err_Handler
		
		SET @ReturnVal = 0
		
		Err_Handler:
			SET @ReturnVal = -1
			
		CleanUp:
			SET @ReturnVal = 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[update_ClientMaster_old]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[update_ClientMaster_old]
@ReturnVal int output,
@clientcd numeric(10),
@Title varchar(5) ,
@FirstName varchar(50) ,
@LastName varchar(50) ,
@birthdate datetime ,
@CompanyNm varchar(250) ,
@Designation varchar(100) ,
@Terms varchar(50) ,
@creditdays numeric(5) ,
@Commission numeric(5,2),
@Brokerage numeric(5,2) ,
@PriceDiscount numeric(5,2),
@Discount numeric(5,2),
@PriceFormat char(10) ,
@TaxDetails varchar(250) ,
@ReferenceFrom varchar(150) ,
@ReferenceThrough varchar(150) ,
@Address varchar(250) ,
@City varchar(50) ,
@State varchar(50) ,
@Zipcode varchar(10) ,
@Countrycd varchar(20) ,
@Phone_Countrycd varchar(10) ,
@Phone_STDcd varchar(10) ,
@Phone_No varchar(100) ,
@Phone_Countrycd2 varchar(10) ,
@Phone_STDCd2 varchar(10) ,
@Phone_No2 varchar(100) ,
@Fax_Countrycd varchar(10) ,
@Fax_STDCd varchar(10) ,
@Fax_No varchar(20) ,
@Mobile_CountryCd varchar(10) ,
@Mobile_No varchar(100) ,
@EmailID1 varchar(75) ,
@EmailID2 varchar(75) ,
@EmailID3 varchar(75) ,
@all_emailid varchar(300),
@Website varchar(100) ,
@BusinessType varchar(150) ,
@UpdatedBy numeric(10),
@WholeStockAccess varchar(1) ,
@bankdetails varchar(4000),
@routingdetails varchar(4000),
@handle_location int,
@smid int,
@emailstatus varchar(10)
AS 
BEGIN

Declare @SavedOn datetime

SET @SavedOn = GetDate()

 	
	BEGIN
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
		WholeStockAccess=@WholeStockAccess,
		bankdetails=@bankdetails,routingdetails=@routingdetails,handle_location=@handle_location,smid=@smid,emailstatus=@emailstatus
		where clientcd=@clientcd
		
			
		SET @ReturnVal = 0
		
		IF @@error <> 0 goto Err_Handler
		
		SET @ReturnVal = 0
		
		Err_Handler:
			SET @ReturnVal = -1
		
		
		CleanUp:
			SET @ReturnVal = 0

	END

END
GO
/****** Object:  StoredProcedure [dbo].[update_ClientMaster]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_ClientMaster]  
@ReturnVal int output,  
@clientcd numeric(10),  
@Title varchar(5) ,  
@FirstName varchar(50) ,  
@LastName varchar(50) ,  
@birthdate datetime ,  
@CompanyNm varchar(250) ,  
@Designation varchar(100) ,  
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
GO
/****** Object:  StoredProcedure [dbo].[TicketmasStatusChange]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[TicketmasStatusChange]
@ReturnVal int output,
@TicketID int,
@status char(1),
@UpdatedBy int
AS 
BEGIN

	Declare @StatusUpdatedOn datetime
	SET @StatusUpdatedOn = GetDate()

	Update Ticketmas SET status=@status, StatusUpdatedOn = @StatusUpdatedOn, UpdatedBy = @UpdatedBy WHERE TicketID = @TicketID

	SET @ReturnVal =0

END
GO
/****** Object:  StoredProcedure [dbo].[UserPassword_Change]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPassword_Change]
@ReturnVal int output,
@USERCD int,
@OldPassword varchar(100),
@NewPassword varchar(100)
AS 
Declare @UpdatedOn datetime
SET @UpdatedOn = GetDate()

IF exists(SELECT USERCD FROM usermas WHERE Password = @OldPassword AND USERCD = @USERCD )
BEGIN
	
	UPDATE usermas SET Password = @NewPassword  WHERE USERCD = @USERCD

	SET @ReturnVal = 0

END
ELSE
BEGIN

	SET @ReturnVal = 1

END
GO
/****** Object:  StoredProcedure [dbo].[Usermas_update]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Usermas_update]
@ReturnVal int output,
@usercd int,
@Title varchar(5),
@FirstName varchar(50),
@LastName varchar(50),
@Designation varchar(100),
@Address varchar(255),
@City varchar(50),
@State varchar(50),
@Zipcode varchar(10),
@CountryID int,
@Phone_CountryCode varchar(10),
@Phone_STDCode varchar(10),
@Phone_Number varchar(10),
@Mobile_CountryCode varchar(10),
@Mobile_Number varchar(15),
@EmailID varchar(75),
@UserRights varchar(2000),
@CreatedBy int,
@IsDeleted char(1)
As

BEGIN

DECLARE  @CreatedOn datetime

-- this is for splitting user rights

BEGIN
	
update usermas set Title=@Title, FirstName=@FirstName, LastName=@LastName, Designation=@Designation, 
Address=@Address, City=@City, State=@State, Zipcode=@Zipcode, CountryID=@CountryID, 
Phone_CountryCode=@Phone_CountryCode, Phone_STDCode=@Phone_STDCode, Phone_Number=@Phone_Number, 
Mobile_CountryCode=@Mobile_CountryCode, Mobile_Number=@Mobile_Number, EmailID=@EmailID, 
UserRights=@UserRights, CreatedBy=@CreatedBy, 
isDeleted=@isDeleted
where usercd=@usercd
	SET @ReturnVal =0
END

END
GO
/****** Object:  StoredProcedure [dbo].[Usermas_Insert]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Usermas_Insert]
@ReturnVal int output,
@UTypeID int,
@UserName varchar(100),
@Password varchar(100),
@Title varchar(5),
@FirstName varchar(50),
@LastName varchar(50),
@Designation varchar(100),
@Address varchar(255),
@City varchar(50),
@State varchar(50),
@Zipcode varchar(10),
@CountryID int,
@Phone_CountryCode varchar(10),
@Phone_STDCode varchar(10),
@Phone_Number varchar(10),
@Mobile_CountryCode varchar(10),
@Mobile_Number varchar(15),
@EmailID varchar(75),
@UserRightsMain varchar(2000),
@UserRights varchar(2000),
@CreatedBy int,
@IsDeleted char(1)
As

BEGIN

DECLARE @InsertedUserCd int, @CreatedOn datetime

-- this is for splitting user rights
DECLARE @NextString NVARCHAR(40)
DECLARE @Pos INT
DECLARE @NextPos INT
DECLARE @String NVARCHAR(2000)
DECLARE @Delimiter NVARCHAR(40)

SET @String = @UserRights
SET @Delimiter = ','
SET @String = @String + @Delimiter
SET @Pos = charindex(@Delimiter,@String)
-- =============================

SET @CreatedOn = GetDate()

SET NOCOUNT ON

If NOT Exists(SELECT UserName FROM usermas WHERE UserName = @UserName and IsDeleted = 'N')
BEGIN
	
	-- Accept the application
	INSERT INTO usermas(UTypeID, UserName, Password, Title, FirstName, LastName, Designation, Address, City, State, Zipcode, CountryID, Phone_CountryCode, Phone_STDCode, Phone_Number, Mobile_CountryCode, Mobile_Number, EmailID, UserRights, CreatedOn, CreatedBy,IsDeleted ) 
	VALUES (@UTypeID, @UserName, @Password, @Title, @FirstName, @LastName, @Designation, @Address, @City, @State, @Zipcode, @CountryID, @Phone_CountryCode, @Phone_STDCode, @Phone_Number, @Mobile_CountryCode, @Mobile_Number, @EmailID, @UserRightsMain, @CreatedOn, @CreatedBy,@IsDeleted)
	
	--IF @@error <> 0 goto Err_Handler
	
	SET @InsertedUserCd = @@identity
	
	-- Inserting user rights 
	-- =======================================
	
	-- =======================================

	SET @ReturnVal =0


END
ELSE
BEGIN
	
	-- Email ID already exists
	SET @ReturnVal = 1

END

	--Err_Handler:
	--SET @ReturnVal = -1
END
GO
/****** Object:  StoredProcedure [dbo].[spPROCMas_Event]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  UserDefinedFunction [dbo].[GETBARCODE]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GETBARCODE](@PSTONEID VARCHAR(30)) 
RETURNS VARCHAR(30) AS
BEGIN
	DECLARE
	@VBARCODE VARCHAR(30)
	BEGIN
		  SELECT @VBARCODE = BARCODE FROM GRADDET WHERE STONEID=@PSTONEID
		END 
		RETURN @VBARCODE
END
GO
/****** Object:  StoredProcedure [dbo].[UserStatusChange]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[UserStatusChange]
@ReturnVal int output,
@userCD int,
@isdeleted char(1),
@UpdatedBy int
AS 
BEGIN

	Declare @UpdatedOn datetime
	SET @UpdatedOn = GetDate()

	Update usermas SET isdeleted=@isdeleted, UpdatedOn = @UpdatedOn,UpdatedBy = @UpdatedBy WHERE usercd = @usercd

	SET @ReturnVal =0

END
GO
/****** Object:  View [dbo].[VIEW_NEW_GRADDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_NEW_GRADDET] AS
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
GO
/****** Object:  View [dbo].[VIEW_MYWATCHLIST]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[VIEW_MYWATCHLIST] AS 
SELECT a.CLIENTCD,title + ' ' + Firstname + ' '+ lastname loginname,emailid1 emailid,curdate,watchlistname,watchlistqry,watchlistorder,a.status
from ClientMaster a,MyWatchlist b
where a.CLIENTCD=b.clientcd
GO
/****** Object:  View [dbo].[VIEW_GRADDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_GRADDET] as
SELECT ROW_NUMBER() OVER (ORDER BY STONEID) AS 'ROW_NUMBER', STONEID, CTS, SHAPE, COLOR, CLARITY, CUT, HA, INCLUSION, 
dbo.getprocvalbytype(FLOURENCE, 'FLOURENCE', 'PROCNM', 'SHORTNM') AS FLSHORTNM, FLOURENCE FLOURENCE, DEPTH, DIATABLE, POLISH, SYM, 
LENGTH, WIDTH, LUSTER, GIRDLE, CULET, PAVILION, CROWN, PAVANGLE, CROWNANGLE, CERTIFICATE, CERTNO, MILKY, SHADE, NATTS, NATURAL, HEIGHT, 
PAVHEIGHT, CROWNHEIGHT, PAIR, ASKRATE_FC, ISNULL(ASKDISC_FC, 0) ASKDISC_FC, ISNULL(ASKAMT_FC, 0) ASKAMT_FC, DBO.GETPROCORD(SHAPE, 
'SHAPE') ordshape, DBO.GETPROCORD(COLOR, 'COLOR') ordcolor, DBO.GETPROCORD(CLARITY, 'CLARITY') ordclarity, DBO.GETPROCORD(CUT, 'CUT') ordcut, 
CURDATE, '[' + dbo.getnewarrivalstatus(curdate) + ']' + '[' + isnull(LEGEND2, '-') + ']' + '[' + isnull(LEGEND3, '-') + ']' STATUS, LOCATION, MEASUREMENT, fl_color, 
ISNULL(RAPARATE, 0) RAPARATE, ROUND(isnull(RAPARATE,0) * CTS, 2) RAPAAMT, dbo.getprocvalbytype(FL_COLOR, 'FL_COLOR', 'PROCNM', 'SHORTNM') 
AS fl_color_shortnm, dbo.getnewarrivalstatus(curdate) legend1, isnull(LEGEND2, '-') legend2, isnull(LEGEND3, '-') legend3, GIRDLE_CONDITION, RATIO, 
STAR_LENGTH, LOWER_HALF, KEY_TO_SYMBOL, REPORT_COMMENT, dbo.get_rapa_size(cts) RapSize, GIRDLEPER, DIA, WEB_CLIENTID, BARCODE, 
COLORDESC, INSCRIPTION, dbo.GET_FANCY_COLOR_STATUS(COLOR) FANCY_COLOR_STATUS, NEW_CERT
FROM dbo.GRADDET
GO
/****** Object:  View [dbo].[VIEW_CLIENTDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CLIENTDET] AS
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
GO
/****** Object:  StoredProcedure [dbo].[spInsertShoppingCart]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertShoppingCart]
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

			select @ISHOLDBYREQUEST = count(1) from ShoppingCart WHERE SC_stoneid=@VSTONEID and sc_status='H'
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
GO
/****** Object:  StoredProcedure [dbo].[sp_isClientValid]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_isClientValid]      
@Username varchar(60),      
@password varchar(50)      
as      
begin      
 IF  EXISTS(SELECT LOGINNAME FROM CLIENTMASTER WHERE LOGINNAME=@USERNAME and password=@password) BEGIN      
  SELECT PASSWORD,CLIENTCD,EMAILID1,TITLE + ' ' + FIRSTNAME + ' ' + LASTNAME CLIENTNAME,FIRSTNAME,STATUS,      
  ISNULL(ADDRESS,'') + ',' + ISNULL(CITY,'') + ',' + ISNULL(STATE,'') + ',' + ISNULL(ZIPCODE,'') + ',' + ISNULL(DBO.GETPROCNM(COUNTRYCD,'COUNTRY'),'') AS CLIENTFULLADDRESS       
  ,DBO.ISSELLER('balaji@siliconsss.com') ISSELLER  ,handle_location     
  ,UTYPEID       
  FROM CLIENTMASTER       
      
  WHERE LOGINNAME=@Username AND PASSWORD =@password COLLATE SQL_LATIN1_GENERAL_CP1_CS_AS      
 end;      
end
GO
/****** Object:  StoredProcedure [dbo].[insert_quotedet]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_quotedet]
@ReturnVal int output,
@quoteid numeric(10),
@cid numeric(10),
@stoneid varchar(50),
@qd_offerrate numeric(15,2),
@qd_offerdisc numeric(5,2)
AS 
BEGIN
		BEGIN
			BEGIN
				INSERT INTO quotedet(cid,quoteid,stoneid,qd_offerrate,qd_offerdisc) 
				values(@cid,@quoteid,@stoneid,@qd_offerrate,@qd_offerdisc)
					
				SET @ReturnVal = 0
				
			END
		END
		
		IF @@error <> 0 goto Err_Handler
			Err_Handler:
				SET @ReturnVal = -1
		

END
GO
/****** Object:  StoredProcedure [dbo].[MyWatchlistStatusChange]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[MyWatchlistStatusChange]
@ReturnVal int output,
@ID int,
@status char(1),
@UpdatedBy int,
@validdays numeric(5)
AS 
BEGIN

	Declare @StatusUpdatedOn datetime
	SET @StatusUpdatedOn = GetDate()

	Update MyWatchlist SET status=@status, StatusUpdatedOn = @StatusUpdatedOn, UpdatedBy = @UpdatedBy WHERE ID = @ID
	SET @ReturnVal =0

END
GO
/****** Object:  StoredProcedure [dbo].[insert_ShoppingCart]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_ShoppingCart]      
@ReturnVal int output,      
@SC_stoneid varchar(50),      
@SC_clientcd int,      
@SC_Status varchar(50),      
@status varchar(50),      
@sc_offerrate numeric(15,2),      
@sc_offerdisc numeric(5,2),      
@sc_biddisc numeric(5,2)=null  
AS      
 BEGIN      
      
  DECLARE @SC_Date datetime      
  DECLARE @ISHOLDBYREQUEST int      
  DECLARE @SC_MemoDate datetime      
  DECLARE @SC_delete_Date datetime      
  SET @SC_Date = GetDate()      
  SET @SC_MemoDate = GetDate()      
  BEGIN      
 IF @SC_Status='I' BEGIN      
  select @SC_delete_Date = getdate() + sc_delete_days from settings      
    END       
 ELSE IF @SC_Status='B' OR @SC_Status='BID' BEGIN      
  select @SC_delete_Date = getdate() + scbr_delete_days from settings      
 END      
  END      
  BEGIN      
 select @ISHOLDBYREQUEST = count(1) from ShoppingCart WHERE SC_stoneid=@SC_stoneid and sc_status='H'      
         
 IF @ISHOLDBYREQUEST > 0 BEGIN  
  goto BuyRequest      
 END      
  END      
  SET NOCOUNT ON      
        
  IF NOT EXISTS (SELECT SC_Id FROM ShoppingCart WHERE SC_clientcd=@SC_clientcd AND SC_stoneid=@SC_stoneid ) BEGIN       
  IF @SC_Status='I' AND @status='insert' BEGIN      
   INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd,SC_Status,       
   SC_Date,SC_delete_Date,sc_offerrate,sc_offerdisc)      
   VALUES(@SC_stoneid, @SC_clientcd,@SC_Status,      
   @SC_Date,@SC_delete_Date,@sc_offerrate,@sc_offerdisc)       
       
   SET @ReturnVal =0      
   RETURN  
  END      
  ELSE IF @SC_Status='B' AND @status='insert' BEGIN      
   INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd,SC_Status,       
   SC_Date,SC_delete_Date,sc_offerrate,sc_offerdisc)      
   VALUES(@SC_stoneid, @SC_clientcd,@SC_Status,       
   @SC_Date,@SC_delete_Date,@sc_offerrate,@sc_offerdisc)      
            
   SET @ReturnVal =0      
   RETURN  
  END      
  ELSE IF @SC_Status='BID' AND @status='insert' BEGIN      
   INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd,SC_Status,       
   SC_Date,SC_delete_Date,sc_offerrate,sc_offerdisc)      
   VALUES(@SC_stoneid, @SC_clientcd,'B',       
   @SC_Date,@SC_delete_Date,@sc_offerrate,@sc_offerdisc)      
            
   SET @ReturnVal =0      
   RETURN  
  END      
  ELSE IF @SC_Status='M' BEGIN  
   IF @status='insert' BEGIN      
    INSERT INTO ShoppingCart(SC_stoneid, SC_clientcd,SC_Status,      
    SC_Date,SC_MemoDate,SC_delete_Date,sc_offerrate,sc_offerdisc)      
    VALUES(@SC_stoneid, @SC_clientcd,@SC_Status,       
    @SC_Date,@SC_MemoDate,@SC_delete_Date,@sc_offerrate,@sc_offerdisc)      
   END       
  ELSE BEGIN      
   UPDATE ShoppingCart SET SC_MemoDate=@SC_MemoDate,SC_Status=@SC_Status ,      
   sc_offerrate=@sc_offerrate,sc_offerdisc=@sc_offerdisc      
   WHERE SC_stoneid=@SC_stoneid AND SC_clientcd=@SC_clientcd      
  END      
            
   SET @ReturnVal =0       
   RETURN  
  END       
        
  ELSE BEGIN      
   SET @ReturnVal = 1      
  END        
 END       
 ELSE BEGIN      
  UPDATE ShoppingCart SET SC_Status=@SC_Status ,      
  sc_offerrate=@sc_offerrate,sc_offerdisc=@sc_offerdisc,sc_delete_date=@sc_delete_date      
  WHERE SC_stoneid=@SC_stoneid AND SC_clientcd=@SC_clientcd      
  SET @ReturnVal = 1      
 END       
         
  BuyRequest:      
  SET @ReturnVal = -2      
 END      
RETURN
GO
/****** Object:  StoredProcedure [dbo].[insert_MyWatchlist]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_MyWatchlist]
@ReturnVal int output,
@clientcd int,
@watchlistname varchar(1000),
@watchlistqry varchar(1000),
@watchlistorder varchar(1000),
@pagesize numeric(5),
@validdays numeric(5),
@status varchar(2)
AS 
BEGIN

Declare @SavedOn datetime,@Completedate datetime

SET @SavedOn = GetDate()
SET @Completedate = GetDate() + @validdays
 	
		BEGIN
			
			INSERT INTO MyWatchlist(clientcd,curdate,watchlistname,watchlistqry,watchlistorder,pagesize,validdays,status,completedate) 
			values(@clientcd,@SavedOn,@watchlistname,@watchlistqry,@watchlistorder,@pagesize,@validdays,@status,@Completedate)
				
			SET @ReturnVal = 0
		
			IF @@error <> 0 goto Err_Handler
			
			SET @ReturnVal = 0
			
			Err_Handler:
				SET @ReturnVal = -1
			
			
			CleanUp:
				SET @ReturnVal = 0
		END    
END
GO
/****** Object:  UserDefinedFunction [dbo].[getwatchlistcount]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getwatchlistcount](@pclientcd numeric(10))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select count(1) FROM mywatchlist WHERE clientcd=@pclientcd and status='Y')
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getshoppingcartdet]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getshoppingcartdet](@pclientcd numeric(10),@ptype varchar(20))
RETURNS VARCHAR(100)
AS
	BEGIN
	IF @ptype='BUYREQUEST' 
	BEGIN 
		RETURN (select  count(1) from shoppingcart
		where sc_clientcd=@pclientcd and sc_status='B' and (sc_delete_date > getdate() or sc_delete_date is null)
		and (sc_stoneid) in (select stoneid from graddet))
	END 
	
	IF @ptype='SHOPPINGCART' 
	BEGIN 
		RETURN (select  count(1) from shoppingcart
		where sc_clientcd=@pclientcd and sc_status='I' and (sc_delete_date > getdate() or sc_delete_date is null)
		and (sc_stoneid) in (select stoneid from graddet))
	END 
	IF @ptype='MEMO' 
	BEGIN 
		RETURN (select  count(1) from graddet
		where web_clientid=@pclientcd and web_clientid is not null )
	END 
	
	RETURN '0'
	
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSCClientOfferValues]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetSCClientOfferValues](@pcolName VARCHAR(255),@pcid VARCHAR(255),@pstoneid VARCHAR(255),@PSTATUS VARCHAR(50))
RETURNS NUMERIC(10,2)
AS
	BEGIN
	   IF @PCOLNAME ='SCRATE'
	   BEGIN
			RETURN (SELECT NULLIF(SC_OFFERRATE,0.0) FROM SHOPPINGCART WHERE SC_CLIENTCD =@PCID AND SC_STONEID = @PSTONEID AND SC_STATUS =@PSTATUS)
		END
	
	   IF @PCOLNAME ='SCDISC'
	   BEGIN
			RETURN (SELECT NULLIF(SC_OFFERDISC,0.0) FROM SHOPPINGCART WHERE SC_CLIENTCD =@PCID AND SC_STONEID = @PSTONEID AND SC_STATUS = @PSTATUS)
		END
		
		RETURN '0'	
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getQuotations]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getQuotations](@pclientcd numeric(10),@ptype varchar(20))
RETURNS VARCHAR(100)
AS
	BEGIN
	IF @ptype='QUOTEMAS' 
	BEGIN 
		RETURN (select  count(1) from quotemas 
		where cid=@pclientcd and status='P')
	END 
	
	IF @ptype='QUOTEDET' 
	BEGIN 
		RETURN (select  count(1) from quotedet
		where cid=@pclientcd and (stoneid) in (select stoneid from graddet))
	END 
	
	RETURN '0'
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetQDClientOfferValues]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetQDClientOfferValues](@pcolName VARCHAR(255),@pcid VARCHAR(255),@pstoneid VARCHAR(255),@QID VARCHAR(255))
RETURNS NUMERIC(10,2)
AS
	BEGIN
	   IF @PCOLNAME ='BIDRATE'
	   BEGIN
			RETURN (SELECT NULLIF(QD_OFFERRATE,0.0) FROM QUOTEDET WHERE CID =@PCID AND STONEID = @pstoneid  AND QUOTEID=@QID)
		END
	
	   IF @PCOLNAME ='BIDDISC'
	   BEGIN
			RETURN (SELECT NULLIF(QD_OFFERDISC,0.0) FROM QUOTEDET WHERE CID =@PCID AND STONEID = @pstoneid  AND QUOTEID=@QID)
		END
				
		RETURN '0'	
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetQDClientOfferRate]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetQDClientOfferRate](@pcid VARCHAR(255),@pstoneid VARCHAR(255),@QID VARCHAR(255))
RETURNS NUMERIC(10,2)
AS
	BEGIN
      RETURN (SELECT NULLIF(QD_OFFERRATE,0.0) FROM QUOTEDET WHERE CID =@PCID AND STONEID = @pstoneid  AND QUOTEID=@QID)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetQDClientOfferDisc]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetQDClientOfferDisc](@pcid VARCHAR(255),@pstoneid VARCHAR(255),@QID VARCHAR(255))
RETURNS NUMERIC(10,2)
AS
	BEGIN
      RETURN (SELECT NULLIF(QD_OFFERDISC,0.0) FROM QUOTEDET WHERE CID =@PCID AND STONEID = @pstoneid  AND QUOTEID=@QID)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetLegend3Status]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetLegend3Status](@pclientcd varchar(60),@pstoneid varchar(60),@curlegend3 varchar(10))
RETURNS VARCHAR(1)
AS
BEGIN
	DECLARE @cnt numeric(10),@SC_STATUS VARCHAR(1),@TOTCNT numeric(10),@MIN_SC_ID numeric(10),@CUR_SC_ID NUMERIC(10)
	DECLARE @ReturnVal varchar(2)
	---------------------------
	BEGIN
	SET @ReturnVal = @curlegend3
	END
	---------------------------
	select @TOTCNT= count(1) from shoppingcart where sc_stoneid = @pstoneid  and sc_status='B'
	select @MIN_SC_ID= MIN(SC_ID) from shoppingcart where sc_stoneid = @pstoneid  and sc_status='B'
 	IF @TOTCNT >= 1
	BEGIN
		SET @ReturnVal = 'H'
	END
	-----------------------
	 select @SC_STATUS = sc_status from shoppingcart where sc_clientcd=@pclientcd and sc_stoneid = @pstoneid 
	 select @CUR_SC_ID = SC_ID from shoppingcart where sc_clientcd=@pclientcd and sc_stoneid = @pstoneid 
 	IF @SC_STATUS = 'B'
	BEGIN
		IF @CUR_SC_ID = @MIN_SC_ID BEGIN
		 SET @ReturnVal = 'B'
		END
		ELSE
		BEGIN			
		 SET @ReturnVal = 'H'
		END
		 
	END
	---------------------------
	Handle:
    RETURN @ReturnVal 
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetClientRejStatus]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetClientRejStatus](@pcid VARCHAR(255),@pstoneid VARCHAR(255)	)
RETURNS NUMERIC(10,2)
AS
	BEGIN
      RETURN (SELECT SC_REJ_STATUS FROM SHOPPINGCART WHERE SC_CLIENTCD =@PCID AND SC_STONEID = @pstoneid )
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetClientOfferDisc]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetClientOfferDisc](@pcid VARCHAR(255),@pstoneid VARCHAR(255)	)
RETURNS NUMERIC(10,2)
AS
	BEGIN
      RETURN (SELECT NULLIF(sc_offerdisc,0.0) FROM SHOPPINGCART WHERE SC_CLIENTCD =@PCID AND SC_STONEID = @pstoneid AND sc_STATUS ='B')
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetClientOfferDate]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetClientOfferDate](@pcid VARCHAR(255),@pstoneid VARCHAR(255)	)
RETURNS datetime
AS
	BEGIN
      RETURN (SELECT sc_date FROM SHOPPINGCART WHERE SC_CLIENTCD =@PCID AND SC_STONEID = @pstoneid AND sc_STATUS ='B')
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getbuyrequestpending]    Script Date: 10/12/2016 16:55:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getbuyrequestpending](@pclientcd numeric(10))
RETURNS VARCHAR(100)
AS
	BEGIN
  RETURN (select  count(1) from shoppingcart
	where sc_clientcd=@pclientcd and sc_status='B' and (sc_delete_date > getdate() or sc_delete_date is null))
	END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_EXCEL_STOCK_ERRORS]    Script Date: 10/12/2016 16:55:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_EXCEL_STOCK_ERRORS]() RETURNS   
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
GO
/****** Object:  StoredProcedure [dbo].[delete_shoppingcart]    Script Date: 10/12/2016 16:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_shoppingcart]
@ReturnVal int output,
@Ptype varchar(50)
AS
BEGIN
	DECLARE
		@SYSDATE DATETIME
	BEGIN
	    SELECT @SYSDATE = GETDATE()
        BEGIN
			IF @PTYPE='SC'
				BEGIN 
					UPDATE SHOPPINGCART SET SC_STATUS='O' where sc_delete_date <= @SYSDATE AND SC_STATUS='I' 
				END 
			IF @PTYPE='SCBR'
				BEGIN 
					UPDATE SHOPPINGCART SET SC_STATUS='O' where sc_delete_date <= @SYSDATE AND SC_STATUS='B' 
				END 	
		IF @@error <> 0 goto Err_Handler
		SET @ReturnVal = 0
		
		Err_Handler:
			SET @ReturnVal = -1
		
		
		CleanUp:
			SET @ReturnVal = 0

		END
	END
END
GO
/****** Object:  View [dbo].[ADMINVIEW_GRADDET]    Script Date: 10/12/2016 16:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ADMINVIEW_GRADDET] as
SELECT STONEID, CTS, SHAPE, COLOR, CLARITY, CUT, HA, INCLUSION, dbo.getprocvalbytype(FLOURENCE, 'FLOURENCE', 'PROCNM', 'SHORTNM') 
AS FLSHORTNM, FLOURENCE, DEPTH, DIATABLE, POLISH, SYM, LENGTH, WIDTH, LUSTER, GIRDLE, CULET, PAVILION, CROWN, PAVANGLE, 
CROWNANGLE, CERTIFICATE, CERTNO, MILKY, SHADE, NATTS, [NATURAL], HEIGHT, PAVHEIGHT, CROWNHEIGHT, PAIR, ISNULL(ASKRATE_FC, 0) 
AS ASKRATE_FC, ISNULL(ASKDISC_FC, 0) AS ASKDISC_FC, ISNULL(ASKAMT_FC, 0) AS ASKAMT_FC, ISNULL(COSTRATE_FC,0)COSTRATE_FC, ISNULL(COSTDISC_FC,0)COSTDISC_FC, ISNULL(COSTAMT_FC,0)COSTAMT_FC, 
dbo.getprocord(SHAPE, 'SHAPE') AS ORDSHAPE, dbo.getprocord(COLOR, 'COLOR') AS ORDCOLOR, dbo.getprocord(CLARITY, 'CLARITY') 
AS ORDCLARITY, dbo.getprocord(CUT, 'CUT') AS ORDCUT, CURDATE, '[' + dbo.getnewarrivalstatus(CURDATE) + ']' + '[' + ISNULL(LEGEND2, '-') 
+ ']' + '[' + ISNULL(LEGEND3, '-') + ']' AS STATUS, LOCATION, MEASUREMENT, FL_COLOR, ISNULL(RAPARATE, 0) AS RAPARATE, 
dbo.getprocvalbytype(FL_COLOR, 'FL_COLOR', 'PROCNM', 'SHORTNM') AS FL_COLOR_SHORTNM, dbo.getnewarrivalstatus(CURDATE) AS LEGEND1, 
ISNULL(LEGEND2, '-') AS LEGEND2, ISNULL(LEGEND3, '-') AS LEGEND3, GIRDLE_CONDITION, RATIO, STAR_LENGTH, LOWER_HALF, 
KEY_TO_SYMBOL, REPORT_COMMENT, isnull(RAPAAMT,0)RAPAAMT, dbo.GET_RAPA_SIZE(CTS) AS RAPSIZE, GIRDLEPER, DIA, BARCODE, COLORDESC, INSCRIPTION, 
dbo.GET_FANCY_COLOR_STATUS(COLOR) AS FANCY_COLOR_STATUS, NEW_CERT
FROM dbo.GRADDET
GO
/****** Object:  Default [DF__clientmas__UType__45BE5BA9]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[clientmaster] ADD  DEFAULT ((0)) FOR [UTypeID]
GO
/****** Object:  Default [DF__GRADDET__wl_rej___0C85DE4D]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[GRADDET] ADD  DEFAULT ('N') FOR [wl_rej_status]
GO
/****** Object:  Default [df_procmas_changeable]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[procmas] ADD  CONSTRAINT [df_procmas_changeable]  DEFAULT ((1)) FOR [isChangeable]
GO
/****** Object:  Default [DF__quotedet__qd_rej__0E6E26BF]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[quotedet] ADD  DEFAULT ('N') FOR [qd_rej_status]
GO
/****** Object:  Default [DF__ShoppingC__sc_re__0D7A0286]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[ShoppingCart] ADD  DEFAULT ('N') FOR [sc_rej_status]
GO
/****** Object:  Check [CH_CLARITYMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[CLARITYMAS]  WITH NOCHECK ADD  CONSTRAINT [CH_CLARITYMAS_STATUS] CHECK  (([STATUS]='N' OR [STATUS]='Y'))
GO
ALTER TABLE [dbo].[CLARITYMAS] CHECK CONSTRAINT [CH_CLARITYMAS_STATUS]
GO
/****** Object:  Check [NN_CLARITYMAS_CLARITYNM]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[CLARITYMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_CLARITYMAS_CLARITYNM] CHECK  (([CLARITYNM] IS NOT NULL))
GO
ALTER TABLE [dbo].[CLARITYMAS] CHECK CONSTRAINT [NN_CLARITYMAS_CLARITYNM]
GO
/****** Object:  Check [NN_CLARITYMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[CLARITYMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_CLARITYMAS_STATUS] CHECK  (([STATUS] IS NOT NULL))
GO
ALTER TABLE [dbo].[CLARITYMAS] CHECK CONSTRAINT [NN_CLARITYMAS_STATUS]
GO
/****** Object:  Check [CH_COLORMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[COLORMAS]  WITH NOCHECK ADD  CONSTRAINT [CH_COLORMAS_STATUS] CHECK  (([STATUS]='N' OR [STATUS]='Y'))
GO
ALTER TABLE [dbo].[COLORMAS] CHECK CONSTRAINT [CH_COLORMAS_STATUS]
GO
/****** Object:  Check [NN_COLORMAS_COLORNM]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[COLORMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_COLORMAS_COLORNM] CHECK  (([COLORNM] IS NOT NULL))
GO
ALTER TABLE [dbo].[COLORMAS] CHECK CONSTRAINT [NN_COLORMAS_COLORNM]
GO
/****** Object:  Check [NN_COLORMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[COLORMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_COLORMAS_STATUS] CHECK  (([STATUS] IS NOT NULL))
GO
ALTER TABLE [dbo].[COLORMAS] CHECK CONSTRAINT [NN_COLORMAS_STATUS]
GO
/****** Object:  Check [nn_quotemas_cid]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[quotemas]  WITH NOCHECK ADD  CONSTRAINT [nn_quotemas_cid] CHECK  (([cid] IS NOT NULL))
GO
ALTER TABLE [dbo].[quotemas] CHECK CONSTRAINT [nn_quotemas_cid]
GO
/****** Object:  Check [nn_quotemas_curdate]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[quotemas]  WITH NOCHECK ADD  CONSTRAINT [nn_quotemas_curdate] CHECK  (([curdate] IS NOT NULL))
GO
ALTER TABLE [dbo].[quotemas] CHECK CONSTRAINT [nn_quotemas_curdate]
GO
/****** Object:  Check [nn_quotemas_status]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[quotemas]  WITH NOCHECK ADD  CONSTRAINT [nn_quotemas_status] CHECK  (([status]='S' OR [status]='O' OR [status]='P'))
GO
ALTER TABLE [dbo].[quotemas] CHECK CONSTRAINT [nn_quotemas_status]
GO
/****** Object:  Check [CH_SHAPEMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SHAPEMAS]  WITH NOCHECK ADD  CONSTRAINT [CH_SHAPEMAS_STATUS] CHECK  (([STATUS]='N' OR [STATUS]='Y'))
GO
ALTER TABLE [dbo].[SHAPEMAS] CHECK CONSTRAINT [CH_SHAPEMAS_STATUS]
GO
/****** Object:  Check [NN_SHAPEMAS_SHAPENM]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SHAPEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SHAPEMAS_SHAPENM] CHECK  (([SHAPENM] IS NOT NULL))
GO
ALTER TABLE [dbo].[SHAPEMAS] CHECK CONSTRAINT [NN_SHAPEMAS_SHAPENM]
GO
/****** Object:  Check [NN_SHAPEMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SHAPEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SHAPEMAS_STATUS] CHECK  (([STATUS] IS NOT NULL))
GO
ALTER TABLE [dbo].[SHAPEMAS] CHECK CONSTRAINT [NN_SHAPEMAS_STATUS]
GO
/****** Object:  Check [CH_SIZEMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SIZEMAS]  WITH NOCHECK ADD  CONSTRAINT [CH_SIZEMAS_STATUS] CHECK  (([STATUS]='N' OR [STATUS]='Y'))
GO
ALTER TABLE [dbo].[SIZEMAS] CHECK CONSTRAINT [CH_SIZEMAS_STATUS]
GO
/****** Object:  Check [NN_SIZEMAS_FCTS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SIZEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SIZEMAS_FCTS] CHECK  (([FCTS] IS NOT NULL))
GO
ALTER TABLE [dbo].[SIZEMAS] CHECK CONSTRAINT [NN_SIZEMAS_FCTS]
GO
/****** Object:  Check [NN_SIZEMAS_SIZENM]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SIZEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SIZEMAS_SIZENM] CHECK  (([SIZENM] IS NOT NULL))
GO
ALTER TABLE [dbo].[SIZEMAS] CHECK CONSTRAINT [NN_SIZEMAS_SIZENM]
GO
/****** Object:  Check [NN_SIZEMAS_STATUS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SIZEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SIZEMAS_STATUS] CHECK  (([STATUS] IS NOT NULL))
GO
ALTER TABLE [dbo].[SIZEMAS] CHECK CONSTRAINT [NN_SIZEMAS_STATUS]
GO
/****** Object:  Check [NN_SIZEMAS_TCTS]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[SIZEMAS]  WITH NOCHECK ADD  CONSTRAINT [NN_SIZEMAS_TCTS] CHECK  (([TCTS] IS NOT NULL))
GO
ALTER TABLE [dbo].[SIZEMAS] CHECK CONSTRAINT [NN_SIZEMAS_TCTS]
GO
/****** Object:  ForeignKey [FK_WL_CLIENTCD]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[MyWatchlist]  WITH CHECK ADD  CONSTRAINT [FK_WL_CLIENTCD] FOREIGN KEY([clientcd])
REFERENCES [dbo].[clientmaster] ([CLIENTCD])
GO
ALTER TABLE [dbo].[MyWatchlist] CHECK CONSTRAINT [FK_WL_CLIENTCD]
GO
/****** Object:  ForeignKey [fk_quotedet_quoteid]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[quotedet]  WITH NOCHECK ADD  CONSTRAINT [fk_quotedet_quoteid] FOREIGN KEY([quoteid])
REFERENCES [dbo].[quotemas] ([quoteid])
GO
ALTER TABLE [dbo].[quotedet] CHECK CONSTRAINT [fk_quotedet_quoteid]
GO
/****** Object:  ForeignKey [FK_SC_CLIENTCD]    Script Date: 10/12/2016 16:55:12 ******/
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_SC_CLIENTCD] FOREIGN KEY([SC_Clientcd])
REFERENCES [dbo].[clientmaster] ([CLIENTCD])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_SC_CLIENTCD]
GO
