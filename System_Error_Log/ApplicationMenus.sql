--CREATE TABLE [TrackerApplicationMenus](
--	[SNo] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
--	[Module] [int] NULL,
--	[FunctionId] [varchar](10) NOT NULL,
--	[MenuName] [varchar](100) NULL,
--	[MenuDescription] [varchar](100) NULL,
--	[LinkPage] [varchar](100) NULL,
--	[MenuGroup] [varchar](40) NULL,
--	[GroupPosition] [int] NULL,
--	[Position] [int] NULL,
--	[IsActive] [char](1) NULL,
--	[CreatedBy] [varchar](30) NULL,
--	[CreatedDate] [datetime] NULL,
--	[ModifiedBy] [varchar](30) NULL,
--	[ModifiedDate] [datetime] NULL,
-- CONSTRAINT [PK_trackerApplicationMenus] PRIMARY KEY CLUSTERED 
--(
--	[SNo] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO

--CREATE TABLE [dbo].[TrackerApplicationFunctions](
--	[FunctionId] [varchar](10) NOT NULL,
--	[ParentFunctionId] [varchar](10) NULL,
--	[FunctionName] [varchar](50) NULL,
--	[CreatedBy] [varchar](50) NULL,
--	[CreatedDate] [datetime] NULL,
--	[ModifiedBy] [varchar](50) NULL,
--	[ModifiedDate] [datetime] NULL,
--	 CONSTRAINT [pk_idx_trackerApplicationFunctions_functionId] PRIMARY KEY CLUSTERED 
--(
--	[FunctionId] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO

alter PROC proc_AddFunction (
	 @FunctionId VARCHAR(8)
	,@ParentFunctionId VARCHAR(8)
	,@FunctionText VARCHAR(200)
)
AS
IF NOT EXISTS (SELECT 'X' FROM TrackerApplicationFunctions WHERE functionId = @FunctionId)
BEGIN
	INSERT INTO TrackerApplicationFunctions (functionId, parentFunctionId, functionName)
	SELECT @FunctionId, @ParentFunctionId, @FunctionText
	PRINT 'Added function ' + @FunctionId
END	

alter PROC [dbo].[proc_addMenu]
	 @module			VARCHAR(2)
	,@functionId		VARCHAR(8)	
	,@menuName			VARCHAR(50)
	,@menuDescription	VARCHAR(50)
	,@linkPage			VARCHAR(255)
	,@menuGroup			VARCHAR(50)
	,@groupPosition		INT
	,@position			INT
	,@isActive			CHAR(1)
	
		
AS

IF NOT EXISTS (SELECT 'X' FROM TrackerApplicationMenus WHERE functionId = @functionId)
BEGIN	

	INSERT INTO TrackerApplicationMenus (
		module, functionId, menuName, menuDescription, linkPage, menuGroup, groupPosition,position, isActive 
	)
	SELECT @module, @functionId, @menuName, @menuDescription, @linkPage, @menuGroup,  @groupPosition,@position, @isActive
	PRINT @menuName  + ' menu added.'		
END

