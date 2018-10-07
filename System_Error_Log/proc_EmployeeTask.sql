USE [customer]
GO
/****** Object:  StoredProcedure [dbo].[proc_EmployeeOperation]    Script Date: 10/05/2018 3:16:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE TABLE Employee(Id INT PRIMARY KEY IDENTITY,Name NVARCHAR(100),Gender NVARCHAR(20),
Salary FLOAT,Address NVARCHAR(100),Email NVARCHAR(255),Dob DATETIME,Occupation NVARCHAR(50),
IdType NVARCHAR(50),WalletNumber NVARCHAR(100),MobileNumber NVARCHAR(20),CreatedBy NVARCHAR(50)
,CreatedDate DATETIME,ModifiedBy NVARCHAR(50),ModifiedDate DATETIME)

*/
alter proc [dbo].[proc_EmployeeTask]
	 @flag			CHAR(5)	
	,@name			nVARCHAR(100)	= NULL
	,@gender		nVARCHAR(20)	= NULL		
	,@salary		FLOAT			= NULL
	,@address		nVARCHAR(100)   = NULL	
	,@email			nVARCHAR(255)   = NULL
	,@dob			DateTime        = NULL
	,@occupation	nvarchar(50)	= NULL	
	,@idType		nVARCHAR(50)	= NULL
	,@walletNumber	nVARCHAR(100)	= NULL
	,@mobileNumber	NVARCHAR(20)	= NULL
	,@createdBy		VARCHAR(50)		= NULL
	,@createdDate	DATETIME		= NULL  
	,@modifiedBy	VARCHAR(50)		= NULL	
	,@modifiedDate	DATETIME		= NULL  
	,@Id			INT				= NULL
	
AS

	SET NOCOUNT ON
	SET XACT_ABORT ON
   	BEGIN TRY
	  	
		IF @flag = 'i'
			BEGIN
				IF EXISTS(SELECT 'X' FROM dbo.Employee(NOLOCK) s  WHERE s.Name= @name)
				BEGIN
					SELECT 1 ErrorCode, 'User Name already exists.' mes, NULL paramKey
					RETURN
				END
				IF(	@name IS  NULL OR @gender IS  NULL OR @salary IS  NULL
					OR @address IS  NULL OR @email IS  NULL OR @dob IS  NULL OR
					@occupation IS  NULL OR @idType IS  NULL OR @walletNumber IS  NULL 
					OR @mobileNumber IS NULL
					)
				BEGIN
					SELECT 1 ErrorCode, 'Required field are empty or invalid.' mes, NULL paramKey
					RETURN
				END
                
		
				BEGIN TRANSACTION	
					INSERT INTO dbo.Employee(
						Name	
						,Gender
						,Salary
						,Address
						,Email
						,Dob
						,Occupation
						,IdType
						,WalletNumber
						,MobileNumber
						,CreatedBy
						,CreatedDate
						,ModifiedBy
						,ModifiedDate)
					       
					SELECT 	
					 @name
					 ,@gender
					 ,@salary
					 ,@address
					 ,@email
					 ,@dob
					 ,@occupation
					 ,@idType
					 ,@walletNumber
					 ,@mobileNumber
					 ,'admin'
					 ,GETDATE()
					 ,NULL
					 ,NULL
					 				
					SET @Id = SCOPE_IDENTITY()
				COMMIT TRANSACTION

				SELECT
					ErrorCode='0',
					mes='New Employee with Id ='+CAST(@Id AS VARCHAR)+' has been added successfully.',
					Id=@Id
				FROM dbo.Employee(NOLOCK) emp
				Return	
			END
		ELSE IF @flag = 'd'
			BEGIN
				IF @Id IS NULL
					BEGIN
						SELECT 1 ErrorCode,'Id field is Required' mes,NULL Id
						RETURN
					END
				IF NOT EXISTS(SELECT 'X' FROM dbo.Employee(NOLOCK) s  WHERE s.Id=@Id)
					BEGIN
						SELECT 1 ErrorCode,'Employee Id = ' + CAST(@Id AS VARCHAR) + ' doesnot exists.' mes,@Id Id
						RETURN
					END
				ELSE
				BEGIN TRANSACTION
					DELETE FROM dbo.Employee WHERE Id = @Id
				COMMIT TRANSACTION
				SELECT ErrorCode='0', mes='Employee with Id= '+CAST(@Id AS VARCHAR(50))+' successfully deleted.' , Id=@Id	
				Return
			END
		ELSE IF @flag = 'u'
			BEGIN
				IF @Id IS NULL
					BEGIN
						SELECT 1 ErrorCode,'Id field is Required' mes,NULL Id
						RETURN
					END
				IF(	@name IS  NULL OR @gender IS  NULL OR @salary IS  NULL
					OR @address IS  NULL OR @email IS  NULL OR @dob IS  NULL OR
					@occupation IS  NULL OR @idType IS  NULL OR @walletNumber IS  NULL 
					OR @mobileNumber IS NULL
					)
					BEGIN
						SELECT 1 ErrorCode, 'Required field are empty or invalid.' mes, NULL paramKey
						RETURN
					END
				IF NOT EXISTS(SELECT 'X' FROM dbo.Employee(NOLOCK) s  WHERE s.Id=@Id)
					BEGIN
						SELECT 1 ErrorCode,'Employee Id = ' + CAST(@Id AS VARCHAR) + ' doesnot exists.' mes,@Id Id
						RETURN
					END
				ELSE
				BEGIN TRANSACTION
						UPDATE s SET
									s.Name=ISNULL(@name,Name),
									s.Gender=ISNULL(@gender,Gender)		
									,s.Salary=ISNULL(@salary,Salary)
									,s.Address=ISNULL(@address,Address)
									,s.Email=ISNULL(@email,Email)
									,s.Dob=ISNULL(@dob,Dob)
									,s.Occupation=ISNULL( @occupation,Occupation)
									,s.IdType=ISNULL(@idType,IdType)
									,s.WalletNumber=ISNULL(@walletNumber,WalletNumber)
									,s.MobileNumber=ISNULL(@mobileNumber,MobileNumber)
									,s.CreatedBy=ISNULL(@createdBy,CreatedBy)
									,s.CreatedDate=ISNULL(@createdDate,CreatedDate)
									,s.ModifiedDate=ISNULL(@modifiedDate,GETDATE())
									,s.ModifiedBy=ISNULL(@modifiedBy,'admin')
						FROM dbo.Employee(NOLOCK) s WHERE s.Id=@Id
				COMMIT TRANSACTION
				SELECT 0 ErrorCode, 'Record with Employee Id = '+CAST(@Id AS VARCHAR)+' Updated Successfully' mes, @Id Id
				Return
			END
		ELSE IF @flag='sa'
			BEGIN
			IF NOT EXISTS(SELECT 'X' FROM dbo.Employee(NOLOCK) s)
				BEGIN
					SELECT 1 ErrorCode,'Employee record doesnot exists.' mes,@Id Id
					RETURN
				END
			ELSE
				BEGIN
					SELECT	ErrorCode='0',
							Id
					        ,Name	
							,Gender
							,Salary
							,Address
							,Email
						    ,Dob=FORMAT ( Dob, 'd', 'en-US' )
							,Occupation
							,IdType
							,WalletNumber
							,MobileNumber,
							mes='Record retrieved Successfully'
							FROM dbo.Employee WITH (NOLOCK)
					SELECT 0 ErrorCode, 'Record retrieved Successfully' mes, @Id Id
					RETURN
				END

			END
		ELSE IF @flag='s-one'
			BEGIN
			IF NOT EXISTS(SELECT 'X' FROM dbo.Employee(NOLOCK) s WHERE s.Id=@Id)
				BEGIN
					SELECT 1 ErrorCode,'Employee record with Id =  '+CAST(@Id AS VARCHAR)+' doesnot exists.' mes,@Id Id
					RETURN
				END
			IF(@Id IS NULL)
				BEGIN
					SELECT 1 ErrorCode, 'Id is required to get single user data.' mes, @Id Id
					Return
				END
			ELSE
				BEGIN
					SELECT	ErrorCode='0',
							e.Id
							,e.Name	
							,e.Gender
							,e.Salary
							,e.Address
							,e.Email
							,Dob=FORMAT ( e.Dob, 'd', 'en-US' )
							,e.Occupation
							,e.IdType
							,e.WalletNumber
							,e.MobileNumber,
							mes='Record retrieved Successfully'
							FROM dbo.Employee e WITH (NOLOCK) WHERE e.Id=@Id
					SELECT 0 ErrorCode, 'Record retrieved Successfully' mes, @Id Id
					RETURN
                END

			END


	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION
			SELECT 1 ErrorCode, ERROR_MESSAGE() mes, @Id paramKey
	END CATCH

	SELECT connectionproperty('local_net_address')
	SELECT * FROM dbo.Employee