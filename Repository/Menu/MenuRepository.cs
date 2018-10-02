using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using ErrorTracking.Repository.DbHelpers;

namespace ErrorTracking.Repository.Menu
{
    public class MenuRepository
    {
        private readonly Dao _dao;

        public MenuRepository()
        {
            this._dao = new Dao();
        }
        public DataTable ObtainMenu(int groupPosition)
        {
            var sql = $@"EXEC proc_menuPopulate  @groupPosition={groupPosition}";
            var db = _dao.ExecuteDataTable(sql);
            return db;
        }
    }
}