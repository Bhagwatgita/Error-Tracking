using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using ErrorTracking.Repository.DbHelpers;

namespace ErrorTracking.Repository.Employee
{
    public class EmployeeRepository
    {
        private readonly Dao _dao;


        public EmployeeRepository()
        {
                this._dao=new Dao();
        }
        public DbResult CreateEmployees(EmployeeModel employeeModel)
        {
            var sql = "EXEC proc_EmployeeTask";
            sql += " @flag = 'i'";
            sql += ", @name = " + _dao.FilterString(employeeModel.Name);
            sql += ", @gender = " + _dao.FilterString(employeeModel.Gender);
            sql += ", @salary = " +_dao.FilterString(Convert.ToString(employeeModel.Salary));
            sql += ", @address = " + _dao.FilterString(employeeModel.Address);
            sql += ", @email = " + _dao.FilterString(employeeModel.Email);
            sql += ", @dob = " + _dao.ParseDate(Convert.ToString(employeeModel.Dob));
            sql += ", @occupation = " + _dao.FilterString(employeeModel.Occupation);
            sql += ", @idType = " + _dao.FilterString(employeeModel.IdType);
            sql += ", @walletNumber = " + _dao.FilterString(employeeModel.WalletNumber);
            sql += ", @mobileNumber = " + _dao.FilterString(employeeModel.MobileNumber);
            return _dao.ParseDbResult(sql);

        }
        public DbResult UpdateEmployees(EmployeeModel employeeModel)
        {
            var sql = "EXEC proc_EmployeeTask";
            sql += " @flag = 'u'";
            sql += ", @name = " + _dao.FilterString(employeeModel.Name);
            sql += ", @gender = " + _dao.FilterString(employeeModel.Gender);
            sql += ", @salary = " + _dao.FilterString(Convert.ToString(employeeModel.Salary));
            sql += ", @address = " + _dao.FilterString(employeeModel.Address);
            sql += ", @email = " + _dao.FilterString(employeeModel.Email);
            sql += ", @dob = " + _dao.ParseDate(Convert.ToString(employeeModel.Dob, CultureInfo.InvariantCulture));
            sql += ", @occupation = " + _dao.FilterString(employeeModel.Occupation);
            sql += ", @idType = " + _dao.FilterString(employeeModel.IdType);
            sql += ", @walletNumber = " + _dao.FilterString(employeeModel.WalletNumber);
            sql += ", @mobileNumber = " + _dao.FilterString(employeeModel.MobileNumber);
            sql += ", @Id = " + _dao.FilterString(employeeModel.Id.ToString());
            return _dao.ParseDbResult(sql);

        }
        public DbResult DeleteEmployees(int id)
        {
            var sql = "EXEC proc_EmployeeTask";
            sql += " @flag = 'd'";
            sql += ", @Id = " + _dao.FilterString(id.ToString());
            return _dao.ParseDbResult(sql);

        }
        public DataTable RetrieveAllEmployees()
        {
            var sql = "EXEC proc_EmployeeTask";
            sql += " @flag = 'sa'";
            return _dao.ExecuteDataTable(sql);

        }
        public DataRow RetrieveSpecificEmployees(int? Id)
        {
            var sql = "EXEC proc_EmployeeTask";
            sql += " @flag = 's-one'";
            sql += ", @Id = " + Id;
            return _dao.ExecuteDataRow(sql);

        }
    }
    public class EmployeeModel
    {
       
        public int Id { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public string Salary { get; set; } 
        public string Address { get; set; }
        public string Email { get; set; }
        public string Dob { get; set; }
        public string Occupation { get; set; }
        public string IdType { get; set; }
        public string WalletNumber { get; set; }
        public string MobileNumber { get; set; }
    }
}