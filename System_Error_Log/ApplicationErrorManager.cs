using System;
using System.Configuration;
using System.Web;
using ErrorTracking.Repository.DbHelpers;

namespace ErrorTracking.System_Error_Log
{
    public static class ApplicationErrorManager
    {
        public static DbResult LogError(HttpException lastError, string page)
        {
            Exception err = lastError;
            if (lastError.InnerException != null)
                err = lastError.InnerException;
            var dao=new Dao();
            
            var errPage = dao.FilterString(page);
            var errMsg = dao.FilterString(err.Message);
            var errDetails = dao.FilterString(lastError.GetHtmlErrorMessage());

            var user = "admin";
            var sql = $@"EXEC proc_ErrorLogs @flag = 'i', @errorPage={errPage}, @errorMsg={errMsg}, @errorDetails={errDetails}, @user = {user}";

            var db = dao.ParseDbResult(sql);
            return db;
        }
        public static long ReadNumericDataFromQueryString(string key)
        {
            var tmpId = ReadQueryString(key, "0");
            long.TryParse(tmpId, out var tmpIdLong);
            return tmpIdLong;
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
        public static string GetVirtualDirName()
        {
            return ReadWebConfig("virtualDirName");
        }
        public static string ReadWebConfig(string key)
        {
            return ReadWebConfig(key, "");
        }
        public static string ReadWebConfig(string key, string defValue)
        {
            return ConfigurationManager.AppSettings[key] ?? defValue;
        }
    }
}