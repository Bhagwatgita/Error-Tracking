using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using ErrorTracking.System_Error_Log;

namespace ErrorTracking.Repository.DbHelpers
{
    public class Dao
    {
        SqlConnection _connection;
        public Dao()
        {
            Init();
        }

        private void Init()
        {
            _connection = new SqlConnection(GetConnectionString());
        }

        private void OpenConnection()
        {
            if (_connection.State == ConnectionState.Open)
                _connection.Close();
            _connection.Open();
        }

        private void CloseConnection()
        {
            if (_connection.State == ConnectionState.Open)
                this._connection.Close();
        }

        private static string GetConnectionString()
        {
            return ConfigurationManager.AppSettings["ApplicationString"].ToString();
            
        }

        public DataSet ExecuteDataset(string sql)
        {
            var ds = new DataSet();
            SqlDataAdapter da;
            try
            {
                OpenConnection();
                da = new SqlDataAdapter(sql, _connection);

                da.Fill(ds);
                da.Dispose();
                CloseConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                da = null;
                CloseConnection();
            }
            return ds;
        }

        public DataTable ExecuteDataTable(string sql)
        {
            using (var ds = ExecuteDataset(sql))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                return ds.Tables[0];
            }
        }

        public DataRow ExecuteDataRow(string sql)
        {
            using (var ds = ExecuteDataset(sql))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                if (ds.Tables[0].Rows.Count == 0)
                    return null;

                return ds.Tables[0].Rows[0];
            }
        }

        public String GetSingleResult(string sql)
        {
            try
            {
                var ds = ExecuteDataset(sql);
                if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                    return "";

                return ds.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            finally
            {
                CloseConnection();
            }
        }

        public String FilterString(string strVal)
        {
            var str = FilterQuote(strVal);

            if (str.ToLower() != "null")
                str = "'" + str + "'";

            return str;
        }

        public String FilterQuote(string strVal)
        {
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "";
            }
            var str = strVal.Trim();

            if (!string.IsNullOrEmpty(str))
            {
                str = str.Replace(";", "");
                //str = str.Replace(",", "");
                str = str.Replace("--", "");
                str = str.Replace("'", "");

                str = str.Replace("/*", "");
                str = str.Replace("*/", "");

                str = str.Replace(" select ", "");
                str = str.Replace(" insert ", "");
                str = str.Replace(" update ", "");
                str = str.Replace(" delete ", "");

                str = str.Replace(" drop ", "");
                str = str.Replace(" truncate ", "");
                str = str.Replace(" create ", "");

                str = str.Replace(" begin ", "");
                str = str.Replace(" end ", "");
                str = str.Replace(" char(", "");

                str = str.Replace(" exec ", "");
                str = str.Replace(" xp_cmd ", "");


                str = str.Replace("<script", "");

            }
            else
            {
                str = "null";
            }
            return str;
        }

        public string SingleQuoteToDoubleQuote(string strVal)
        {
            strVal = strVal.Replace("\"", "");
            return strVal.Replace("'", "\"");
        }
        public string ParseDate(string data)
        {
            data = FilterString(data);
            if (data.ToUpper() == "NULL")
                return data;
            data = data.Replace("'", "");
            var dateParts = data.Split('/');
            if (dateParts.Length < 3)
                return "NULL";
            var m = dateParts[0];
            var d = dateParts[1];
            var y = dateParts[2];

            return "'" + y + "-" + (m.Length == 1 ? "0" + m : m) + "-" + (d.Length == 1 ? "0" + d : d) + "'";

        }
        public static bool ConvertToGlobalFormat(string param)
        {
            try
            {
                DateTime dt = Convert.ToDateTime(param);
                string[] formats = { "mm/dd/yyyy" };

                if (DateTime.TryParseExact(param, formats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out dt))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }

        }

        public DbResult ParseDbResult(DataTable dt)
        {
            var res = new DbResult();
            if (dt.Rows.Count > 0)
            {
                res.ErrorCode = dt.Rows[0][0].ToString();
                res.Msg = dt.Rows[0][1].ToString();
                res.Id = dt.Rows[0][2].ToString();
            }
            if (dt.Columns.Count > 3)
            {
                res.Extra = dt.Rows[0][3].ToString();
            }
            if (dt.Columns.Count > 4)
            {
                res.Extra2 = dt.Rows[0][4].ToString();
            }
            return res;
        }

        public DbResult ParseDbResult(string sql)
        {
            return ParseDbResult(ExecuteDataset(sql).Tables[0]);
        }


    }

   
}
