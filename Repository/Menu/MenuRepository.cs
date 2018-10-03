using System.Data;
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
        public DataSet ObtainMenu()
        {
            var sql = $@"EXEC proc_menuPopulate ";
            var db = _dao.ExecuteDataset(sql);
            return db;
        }
    }
}