DECLARE 
	 @ViewFunctionId	VARCHAR(8)
	,@AddEditFunctionId VARCHAR(8)
	,@DeleteFunctionId	VARCHAR(8)
	,@ApproveFuntionId	VARCHAR(8)
	,@AssignFuntionId	VARCHAR(8)
	,@AssignRoleId		VARCHAR(8)
	,@AssignLimit		VARCHAR(8)
	,@ResetPassword		VARCHAR(8)
	,@LockUser			VARCHAR(8)
	,@UserGroupMapping	VARCHAR(8)
	,@module			VARCHAR(2)
	,@menuName			VARCHAR(50)
	,@menuDescription	VARCHAR(50)
	,@linkPage			VARCHAR(255)
	,@menuGroup			VARCHAR(50)
	,@position			INT
	,@isActive			CHAR(1)
	,@groupPosition		INT

SELECT 
	 @module = '10'

	 
	SELECT		
		@groupPosition = 10
		,@isActive = 'Y'
		,@menuGroup = 'Application Management'

	--1)Default Home Page
	SELECT
		 @ViewFunctionId	= '10101000'
		--,@AddEditFunctionId = '10101010'
		,@menuName			= 'Home'
		,@menuDescription	= 'Home'
		,@linkPage			= '/Default'
		,@position = 1

	EXEC proc_addMenu @module, @ViewFunctionId, @menuName, @menuDescription, @linkPage, @menuGroup, @groupPosition, @position, @isActive
	EXEC proc_AddFunction @ViewFunctionId, @ViewFunctionId, 'View'
	--EXEC proc_AddFunction @AddEditFunctionId, @ViewFunctionId, 'Add/Edit'
	--EXEC proc_AddFunction @AssignRoleId, @ViewFunctionId, 'Assign Role'
	--EXEC proc_AddFunction @ResetPassword, @ViewFunctionId, 'Reset Password'
	--2)Default Home Page
	SELECT
		 @ViewFunctionId	= '10101100'
		,@menuName			= 'Error'
		,@menuDescription	= 'Error'
		,@linkPage			= '/ErrorView/List'
		,@position = 2

	EXEC proc_addMenu @module, @ViewFunctionId, @menuName, @menuDescription, @linkPage, @menuGroup, @groupPosition, @position, @isActive
	EXEC proc_AddFunction @ViewFunctionId, @ViewFunctionId, 'View'
	
	SELECT		
		@groupPosition = 20
		,@isActive = 'Y'
		,@menuGroup = 'User Data'
	--3)About Page
	SELECT
		 @ViewFunctionId	= '10201000'
		,@menuName			= 'About'
		,@menuDescription	= 'About'
		,@linkPage			= '/About'
		,@position = 1

	EXEC proc_addMenu @module, @ViewFunctionId, @menuName, @menuDescription, @linkPage, @menuGroup, @groupPosition, @position, @isActive
	EXEC proc_AddFunction @ViewFunctionId, @ViewFunctionId, 'View'
	--3)Contact Page
	SELECT
		 @ViewFunctionId	= '10201100'
		,@menuName			= 'Contact'
		,@menuDescription	= 'Contact'
		,@linkPage			= '/Contact'
		,@position = 2

	EXEC proc_addMenu @module, @ViewFunctionId, @menuName, @menuDescription, @linkPage, @menuGroup, @groupPosition, @position, @isActive
	EXEC proc_AddFunction @ViewFunctionId, @ViewFunctionId, 'View'