using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
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
        public void SaveEmployee(EmployeeModel emp)
        {
            //if (emp==null)
            //{
            //    emp = new EmployeeModel()
            //    {
            //        Name = $@"Rabindra",
            //        Gender = "Male",
            //        Occupation = "Farmer",
            //        Address = "Kathmandu",
            //        Dob = Convert.ToDateTime("2018-10-03"),
            //        IdType = "CitizenShip-Card",
            //        Email = "rabindra@gmail.com",
            //        MobileNumber = "9845632233",
            //        WalletNumber = "4256",
            //        Salary = Convert.ToDouble(1000)

            //    };
            //}
            //var empResp = new EmployeeModel
            //{
            //    Name = $@"Rabindra",
            //    Gender = "Male",
            //    Occupation = "Farmer",
            //    Address = "Kathmandu",
            //    Dob = Convert.ToDateTime("2018-10-03"),
            //    IdType = "CitizenShip-Card",
            //    Email = "rabindra@gmail.com",
            //    MobileNumber = "9845632233",
            //    WalletNumber = "4256",
            //    Salary = Convert.ToDouble(1000)
            //};
            //_empRepository.CreateEmployees(empResp);
            _empRepository.CreateEmployees(emp);
           
        }
         [WebMethod]
        public void UpdateEmployee(EmployeeModel emp)
        {
            _empRepository.UpdateEmployees(emp);
        }

        [WebMethod]
        public void DeleteEmployees(int id)
        {
            _empRepository.DeleteEmployees(id);
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
                    //DateTime date;
                    //DateTime.TryParseExact(Convert.ToString(row["Dob"]), "MM/dd/yyyy",
                    //    System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None,
                    //    out date);
                    //var dob = Convert.ToString(date);
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


       
    }
}
