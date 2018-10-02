SELECT * FROM dbo.applicationMenus WHERE functionId='20191000'
SELECT * FROM dbo.applicationFunctions WHERE functionId='20191000'
SELECT * FROM applicationRoleFunctions WHERE functionId='20191000'--it have field roleId
SELECT * FROM dbo.applicationUserRoles --it have field roleId
--applicationRoleFunctions and applicationUserRoles have roleId in common so 
--that we can know which user has what role

-- sp_helptext menu_proc