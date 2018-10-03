using System;
using System.Data;
using System.Text;
using System.Web.UI;
using ErrorTracking.Repository.DbHelpers;
using ErrorTracking.Repository.Menu;

namespace ErrorTracking
{
    public partial class SiteMaster : MasterPage
    {
        private readonly Dao _dao;
        private readonly MenuRepository _menuRepository;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownMaker();
            }

        }

        public SiteMaster()
        {
            this._menuRepository = new MenuRepository();
            this._dao = new Dao();
        }

        public void DropDownMaker()
        {
            var menuData = _menuRepository.ObtainMenu();
            var builder = new System.Text.StringBuilder();
            foreach (DataTable dt in menuData.Tables)
            {
                CreateMenuGroup(dt,builder);
            }
            
            navItem.InnerHtml = builder.ToString();



        }

        private void CreateMenuGroup(DataTable menuGroup, StringBuilder builder)
        {
            var data = string.Empty;
            var menuItemText = new string[menuGroup.Rows.Count];
            var menuItemUrl = new string[menuGroup.Rows.Count];
            var i = 0;
            foreach (DataRow row in menuGroup.Rows)
            {
                data = row["MenuGroup"].ToString();
                menuItemText[i] = row["MenuName"].ToString();
                menuItemUrl[i] = row["LinkPage"].ToString();
                i++;
            }

            builder.AppendLine(GenerateDropDownList(data, menuItemText, menuItemUrl));
        }

        public string GenerateDropDownList(string menuGroup,string[] menuItemText,string[] menuItemUrl)
        {
            
             var builder = new System.Text.StringBuilder();
             builder.Append($@"<li><div class='dropdown'>
                            <button class='btn btn-default dropdown-toggle' type='button' data-toggle='dropdown'>{menuGroup}
                             <span class='caret'></span></button>
                            <ul class='dropdown-menu'>");
            for (int i = 0, j = 0; i < menuItemText.Length; i++, j++)
            {
                builder.Append($@"{GenerateDDMenuItem(menuItemText[i], menuItemUrl[j])}");
            }
           
            builder.Append( $@" </ul>
                               </div></li>");
            return builder.ToString();
        }

        public string GenerateDDMenuItem(string menuItemText,string menuItemUrl)
        {
            var strTitle = $@"<li><a href = '{menuItemUrl}' > {menuItemText} </a></li>
                              <li class='divider'></li>";
            return strTitle;
        }

    }
}