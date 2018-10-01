using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using ErrorTracking.Repository.DbHelpers;
using ErrorTracking.System_Error_Log;

namespace ErrorTracking
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        protected void Application_Error(object sender, EventArgs e)
        {
            var err = Server.GetLastError() as HttpException;
            var dr = new DbResult();
            if (err != null)
            {
                var page = HttpContext.Current.Request.Url.ToString();
                dr = ApplicationErrorManager.LogError(err, page);
            }
            Server.ClearError();
            var url = ApplicationErrorManager.GetVirtualDirName() + "/Error.aspx";
            Server.Transfer(url + "?id=" + dr.Id);
        }
    }
}