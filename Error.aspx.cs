using System;
using ErrorTracking.System_Error_Log;

namespace ErrorTracking
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            errLogId.Text = ApplicationErrorManager.ReadNumericDataFromQueryString("id").ToString();
        }
    }
}