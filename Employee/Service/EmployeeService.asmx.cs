using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using ErrorTracking.Repository.DbHelpers;
using ErrorTracking.Repository.Employee;

namespace ErrorTracking.Employee.Service
{
    /// <summary>
    /// Summary description for EmployeeService
    /// </summary>
    [WebService(Namespace = "http://employee.data.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
   [System.Web.Script.Services.ScriptService]
    public class EmployeeService : System.Web.Services.WebService
    {
        private EmployeeRepository _empRepository;

        public EmployeeService()
        {
                this._empRepository=new EmployeeRepository();
        }

        [WebMethod]
        public DbResult SaveEmployee(EmployeeModel emp)
        {
            var dr=_empRepository.CreateEmployees(emp);
            var response = GetResponse(dr);
            return response;

        }
         [WebMethod]
        public DbResult UpdateEmployee(EmployeeModel emp)
        {
            var dr=_empRepository.UpdateEmployees(emp);
            var response = GetResponse(dr);
            return response;
        }

        [WebMethod]
        public DbResult DeleteEmployees(int id)
        {
            var dr=_empRepository.DeleteEmployees(id);
            var response = GetResponse(dr);
            return response;
        }
        [WebMethod]
        public EmployeeModel RetrieveSingleEmployee(int id)
        {
            var emp=new EmployeeModel();
            var dt=_empRepository.RetrieveSpecificEmployees(id);
            if (Convert.ToString(dt["ErrorCode"]) == "1") { }
            else {
             emp = new EmployeeModel
            {
                Id = Convert.ToInt32(dt["Id"]),
                Name = dt["Name"].ToString(),
                Gender = Convert.ToString(dt["Gender"]),
                Occupation = Convert.ToString(dt["Occupation"]),
                Address = Convert.ToString(dt["Address"]),
                Dob = Convert.ToString(dt["Dob"],CultureInfo.CreateSpecificCulture("en-US")),
                Email = Convert.ToString(dt["Email"]),
                IdType = Convert.ToString(dt["IdType"]),
                MobileNumber = Convert.ToString(dt["MobileNumber"]),
                WalletNumber = Convert.ToString(dt["WalletNumber"]),
                Salary = Convert.ToDouble(Convert.ToString(dt["Salary"]))
            };
                
                }
            return emp;
            
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public List<EmployeeModel> RetrieveAllEmployeeData()
        {
            var lstEmployeeResponse = new List<EmployeeModel>();

            var dt = _empRepository.RetrieveAllEmployees();

            foreach (DataRow row in dt.Rows)
            {
                if (Convert.ToString(row["ErrorCode"])=="1")
                {
                    
                }
                else
                {
                  
                    var empResp = new EmployeeModel
                    {
                        Id=Convert.ToInt32(row["Id"]),
                        Name = Convert.ToString(row["Name"]),
                        Gender = Convert.ToString(row["Gender"]),
                        Occupation = Convert.ToString(row["Occupation"]),
                        Address = Convert.ToString(row["Address"]),
                        Dob = Convert.ToString(row["Dob"]),
                        IdType = Convert.ToString(row["IdType"]),
                        Email = Convert.ToString(row["Email"]),
                        MobileNumber = Convert.ToString(row["MobileNumber"]),
                        WalletNumber = Convert.ToString(row["WalletNumber"]),
                        Salary = Convert.ToDouble(Convert.ToString(row["Salary"]))
                    };
                    lstEmployeeResponse.Add(empResp);
                }
            }

            return lstEmployeeResponse;
        }

        private static DbResult GetResponse(DbResult response)
        {

            var dr=new DbResult();
            if (response.ErrorCode.Equals("0"))
            {
                dr.SetError(response.ErrorCode, response.Msg, response.Id);
            }
            else
            {
                dr.SetError(response.ErrorCode, response.Msg, response.Id);
            }

            return response;
        }


       
    }
}
