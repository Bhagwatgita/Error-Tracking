create TABLE [dbo].[Logs](
	[id] [BIGINT] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[errorPage] [VARCHAR](MAX) NULL,
	[errorMsg] [VARCHAR](MAX) NULL,
	[errorDetails] [VARCHAR](MAX) NULL,
	[createdBy] [VARCHAR](50) NULL,
	[createdDate] [DATETIME] NULL,
	[referer] [VARCHAR](MAX) NULL,
	[dcUserName] [VARCHAR](200) NULL,
	[dcIdNo] [VARCHAR](2000) NULL,
	[ipAddress] [VARCHAR](50) NULL,
 CONSTRAINT [pk_idx_Logs_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

alter proc [dbo].[proc_ErrorLogs](
	 @flag VARCHAR(50) = NULL
	,@ID BIGINT = NULL
	,@errorPage VARCHAR(MAX) = NULL
	,@errorMsg VARCHAR(MAX) = NULL
	,@errorDetails VARCHAR(MAX) = NULL
	,@referer VARCHAR(MAX) = NULL
	,@dcUserName VARCHAR(200) = NULL
	,@dcIdNo VARCHAR(2000) = NULL
	,@ipAddress VARCHAR(50) = NULL
	,@user VARCHAR(50) = NULL
	,@createdDate DATETIME = NULL
	,@createdBy VARCHAR(50) = NULL
)

AS
SET NOCOUNT ON

IF @flag = 'i' 
BEGIN
	INSERT INTO Logs (errorPage, errorMsg, errorDetails, createdBy, createdDate, referer, dcUserName, dcIdNo, ipAddress ) 
	SELECT @errorPage, @errorMsg, @errorDetails, @user, GETDATE(), @referer, @dcUserName, @dcIdNo, @ipAddress
	SELECT 0 ErrorCode, 'Logs Recorded' Msg, SCOPE_IDENTITY() id
	RETURN
END
ELSE IF @flag = 'a' 
BEGIN
	SELECT errorPage, errorMsg, errorDetails, referer, dcUserName, dcIdNo, ipAddress FROM Logs (NOLOCK) WHERE id = @id
	RETURN
END
