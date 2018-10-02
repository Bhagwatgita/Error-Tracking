using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ErrorTracking
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string GenerateDropDownList(string menuGroup,string menuItemText,string menuItemUrl,int groupPosition,int position,char isActive)
        {
            var strTitle = $@"<div class='dropdown'>
                            < button class='btn btn-default dropdown-toggle' type='button' data-toggle='dropdown'>{menuGroup}
                             <span class='caret'></span></button>
                            <ul class='dropdown-menu'>";
                 strTitle+=$@"{GenerateDDMenuItem(menuItemText,menuItemUrl)}";
                 strTitle+=$@" </ul>
                               </div>";
            return strTitle;
        }

        public string GenerateDDMenuItem(string menuItemText,string menuItemUrl)
        {
            var strTitle = $@"<li><a href = '{menuItemUrl}' > {menuItemText} </ a ></ li >
                              < li class='divider'></li>";
            return strTitle;
        }

    }
}