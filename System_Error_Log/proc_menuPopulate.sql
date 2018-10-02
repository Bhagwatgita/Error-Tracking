alter PROC proc_menuPopulate
AS
BEGIN
	SELECT [Module]
		  ,[FunctionId]
		  ,[MenuName]
		  ,[MenuDescription]
		  ,[LinkPage]
		  ,[MenuGroup]
		  ,[GroupPosition]
		  ,[Position]
		  ,[IsActive]
	FROM [customer].[dbo].[TrackerApplicationMenus] WITH(NOLOCK)
	SELECT [Module]
		  ,[FunctionId]
		  ,[MenuName]
		  ,[MenuDescription]
		  ,[LinkPage]
		  ,[MenuGroup]
		  ,[GroupPosition]
		  ,[Position]
		  ,[IsActive]
	FROM [customer].[dbo].[TrackerApplicationMenus] WITH(NOLOCK) WHERE [GroupPosition]=10
	SELECT [Module]
		  ,[FunctionId]
		  ,[MenuName]
		  ,[MenuDescription]
		  ,[LinkPage]
		  ,[MenuGroup]
		  ,[GroupPosition]
		  ,[Position]
		  ,[IsActive]
	FROM [customer].[dbo].[TrackerApplicationMenus] WITH(NOLOCK) WHERE [GroupPosition]=20

End