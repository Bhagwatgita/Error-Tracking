<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ErrorTracking.Employee.Create" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Create</title>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="../Scripts/Employee/employee.js"></script>
</head>
<body>

     <div class="container">
        <h2>Employees Record</h2> 
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="clearTextBox();">Add New Employee</button><br /><br />
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>
                        ID
                    </th>
                    <th>
                        Name
                    </th>
                    <th>
                        Gender
                    </th>
                    <th>
                        Salary
                    </th>
                    <th>
                        Address
                    </th>
                    <th>
                        Email
                    </th>
                    <th>
                        Dob
                    </th>
                    <th>
                        Occupation
                    </th>
                    <th>
                        IdType
                    </th>
                     <th>
                        WalletNumber
                    </th>
                     <th>
                        MobileNumber
                    </th>
                </tr>
            </thead>
            <tbody class="tbody">

            </tbody>
        </table>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    @*<button type="button" class="close" data-dissmiss="modal"><span aria-hidden="true">&times;</span></button>*@
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="EmployeeId">ID</label>
                            <input type="text" class="form-control" id="EmployeeID" placeholder="Id" disabled="disabled"/>
                        </div>
                        <div class="form-group">
                            <label for="Name">Name</label>
                            <input type="text" class="form-control" id="Name" placeholder="Name"/>
                        </div>
                        <div class="form-group">
                            <label for="Age">Age</label>
                            <input type="text" class="form-control" id="Age" placeholder="Age" />
                        </div>
                        <div class="form-group">
                            <label for="State">State</label>
                            <input type="text" class="form-control" id="State" placeholder="State"/>
                        </div>
                        <div class="form-group">
                            <label for="Country">Country</label>
                            <input type="text" class="form-control" id="Country" placeholder="Country"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btnAdd" onclick="return Add();">Add</button>
                    <button type="button" class="btn btn-primary" id="btnUpdate" style="display:none;" onclick="Update();">Update</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>        
    </div>
</body>
</html>
