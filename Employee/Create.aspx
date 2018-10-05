<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ErrorTracking.Employee.Create" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Create</title>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/jquery.gritter.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="../Scripts/jquery.gritter.min.js"></script>
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
                   <%-- @*<button type="button" class="close" data-dissmiss="modal"><span aria-hidden="true">&times;</span></button>*@--%>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="Id">ID</label>
                            <input type="number" class="form-control" id="Id" placeholder="Id" disabled="disabled"/>
                        </div>
                        <div class="form-group">
                            <label for="Name">Name</label>
                            <input type="text" class="form-control" id="Name" placeholder="Name"/>
                        </div>
                        <div class="form-group">
                            <label for="Gender">Gender</label>
                            <input type="text" class="form-control" id="Gender" placeholder="Gender" />
                        </div>
                        <div class="form-group">
                            <label for="Salary">Salary</label>
                            <input type="number" class="form-control" id="Salary" placeholder="Salary"/>
                        </div>
                        <div class="form-group">
                            <label for="Address">Address</label>
                            <input type="text" class="form-control" id="Address" placeholder="Address"/>
                        </div>
                          
                          <div class="form-group">
                            <label for="Email">Email</label>
                            <input type="email" class="form-control" id="Email" placeholder="Email"/>
                        </div>
                          <div class="form-group">
                            <label for="Dob">Dob</label>
                            <input type="date"  class="form-control date" id="Dob" placeholder="Dob"/>
                        </div>
                          <div class="form-group">
                            <label for="Occupation">Occupation</label>
                            <input type="text" class="form-control" id="Occupation" placeholder="Occupation"/>
                        </div>
                          <div class="form-group">
                            <label for="IdType">IdType</label>
                            <input type="text" class="form-control" id="IdType" placeholder="IdType"/>
                        </div>
                          <div class="form-group">
                            <label for="WalletNumber">WalletNumber</label>
                            <input type="number" class="form-control" id="WalletNumber" placeholder="WalletNumber"/>
                        </div>
                        <div class="form-group">
                            <label for="MobileNumber">MobileNumber</label>
                            <input type="number" class="form-control" id="MobileNumber" placeholder="MobileNumber"/>
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
