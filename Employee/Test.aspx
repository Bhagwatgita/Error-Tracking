<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="ErrorTracking.Employee.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Create</title>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/jquery.gritter.css" rel="stylesheet" />
    <link href="../Content/bootstrap.validator.min.css" rel="stylesheet" />
    <link href="../Content/themes/base/jquery-ui.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="../Scripts/jquery.gritter.min.js"></script>
    <script src="../Scripts/bootstrap.validator.min.js"></script>
    <%--<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/css/bootstrapValidator.min.css"/>
  <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js">
  </script>--%>
    <script src="../Scripts/Employee/employee.js"></script>
    <style type="text/css">
        .hide {
            display: none;
        }

        .SmallTextBox {
            width: 130px;
        }

        .LargeTextBox {
            width: 425px;
        }


        td {
            font-size: 11px;
        }

        .frmTitle {
            background: #e00024 !important;
        }

        .amountLabel {
            font-size: 16px;
            font-weight: bold;
            color: Red;
            padding: 2px;
        }

        #availableAmt {
            color: Red;
        }

        .mainContainer {
            clear: both;
            width: 850px;
            float: left;
        }

        .rowContainer {
            clear: both;
            display: block;
            float: left;
            margin-bottom: 5px;
        }

        .amountDiv {
            background: none repeat scroll 0 0 black;
            clear: both;
            color: white;
            float: right;
            font-size: 20px;
            font-weight: 600;
            padding: 2px 8px;
            width: auto;
        }

        #mask {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: red;
            z-index: 99;
        }

        label {
            float: left;
        }

            label.error {
                float: none;
                color: red;
                vertical-align: top;
                font-size: 10px;
                font-family: Verdana;
                font-weight: bold;
            }

        .inv {
            float: none;
            color: red;
            vertical-align: top;
            font-size: 10px;
            font-family: Verdana;
            font-weight: bold;
        }

        input.error {
            border-style: solid;
            border-width: 1px;
            background-color: #FFD9D9;
        }

        select.error {
            border-style: solid;
            border-width: 1px;
            background-color: #FFD9D9;
        }

        .disabled {
            background: #EFEFEF !important;
            color: #666666 !important;
        }

        .table th, .table td { 
     border-top: none !important; 
 }
    </style>
</head>
<body>

     <div class="container">
        <h2>Employees Record</h2> 
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="clearTextBox();">Add New Employee</button><br /><br />
        <table class="table table-bordered table-responsive table-hover">
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
                    <th>
                        Action
                    </th>
                </tr>
            </thead>
            <tbody class="tbody">

            </tbody>
        </table>
    </div>
 <div class="rowContainer">
                <table width="840px" cellspacing="0" cellpadding="0" class="formTable">
                    <tr>
                        <td class="frmTitle" colspan="4"> 
                            <div style="float: left;"> Employee Information: <span id="senderName"></span></div> 
                            
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="tblSend" cellspacing="0">
                                <tr>
                                    <td style="width: 135px;">
                                        First Name:
                                        <span class="ErrMsg" id='txtSendFirstName_err'>*</span>  
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSendFirstName" runat="server"  CssClass="required SmallTextBox" ></asp:TextBox>
                                    </td>
                                    <td >Middle Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtSendMidName" runat="server"  CssClass="SmallTextBox" ></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Last Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtSendLastName" runat="server"  CssClass="SmallTextBox" ></asp:TextBox> 
                                        <span class="ErrMsg" id='txtSendLastName_err'></span> 
                                    </td>
                                    <td >Second Last Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtSendSecondLastName" runat="server"  CssClass="SmallTextBox" ></asp:TextBox> 
                                    </td>
                                </tr>
                                <tr id="trSenId" runat="server">
                                    <td>
                                        <asp:Label runat="server" ID="lblsIdtype" Text="ID Type:" ></asp:Label>
                                        <span runat="server" class="ErrMsg" id='ddSenIdType_err'>*</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID = "ddSenIdType" runat = "server" style="width:134px;height:30px;"></asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblSidNo" Text="ID Number:"></asp:Label>
                                        <span runat="server" class="ErrMsg" id='txtSendIdNo_err'>*</span>   
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSendIdNo" runat="server" Width="130px" ></asp:TextBox> <br/>  
                                        <span id="spnIdNumber" style="color: red; font-size: 10px; font-family: verdana; font-weight: bold; display: none;"></span>
                                   </td>
                                </tr>
                                <tr id="trIdExpirenDob" runat="server">
                                    <td id="tdSenExpDateLbl" runat="server">
                                        <asp:Label runat="server" ID="lblsExpDate" Text="ID Expiry Date:"></asp:Label>
                                        <span runat="server" class="ErrMsg" id='txtSendIdValidDate_err'>*</span>
                                    </td>
                                    <td id="tdSenExpDateTxt" runat="server" nowrap="nowrap">
                                        <asp:TextBox ID="txtSendIdValidDate" runat="server" ReadOnly="true" Width="130px" ></asp:TextBox>
                                    </td>   
                                    <td id="tdSenDobLbl" runat="server">
                                        <asp:Label runat="server" ID="lblSDOB" Text="DOB:"></asp:Label>
                                        <span runat="server" class="ErrMsg" id='txtSendDOB_err'>*</span>
                                    </td>
                                    <td id="tdSenDobTxt" runat="server" nowrap="nowrap">
                                        <asp:TextBox ID="txtSendDOB" runat="server" ReadOnly="true" Width="130px"></asp:TextBox>
                                                     
                                    </td>
                                </tr>
                                <tr id="trSenContactNo" runat="server">
                                    <td id="tdSenMobileNoLbl" runat="server">
                                        Mobile No:
                                        <span runat="server"  class="ErrMsg" id='txtSendMobile_err'>*</span>
                                    </td>
                                    <td id="tdSenMobileNoTxt" runat="server">
                                        <asp:TextBox ID="txtSendMobile" runat="server" Width="130px"></asp:TextBox>
                                    </td>
                                    <td id="tdSenTelNoLbl" runat="server"><asp:Label runat="server" ID="lblSTelNo" Text="Tel. No.:"></asp:Label></td>
                                    <td id="tdSenTelNoTxt" runat="server">
                                        <asp:TextBox ID="txtSendTel" runat="server" Width="130px" ></asp:TextBox>    
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tdSenCityLbl" runat="server">
                                        <asp:Label runat="server" ID="lblsCity" Text="City:"></asp:Label>
                                        <span runat="server"  class="ErrMsg" id='txtSendCity_err'>*</span> 
                                    </td>
                                    <td id="tdSenCityTxt" runat="server">
                                        <asp:TextBox ID="txtSendCity" runat="server" Width="130px"></asp:TextBox>               
                                    </td>
                                    <td>Postal Code:</td>
                                    <td>
                                        <asp:TextBox ID="txtSendPostal" runat="server" Width="130px"></asp:TextBox>              
                                    </td>
                                </tr>
                                <tr id="trSenCompany" runat="server">
                                    <td>
                                        <asp:Label runat="server" ID="lblCompName" Text="Company Name:"></asp:Label>
                                        <span runat="server" class="ErrMsg" id='companyName_err'>*</span>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="companyName" runat="server" Width="425px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trSenAddress1" runat="server">
                                    <td>
                                        Address1:
                                        <span runat="server" class="ErrMsg" id='txtSendAdd1_err'>*</span>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtSendAdd1" runat="server" Width="425px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trSenAddress2" runat="server">
                                    <td>Address2:</td>
                                    <td colspan="3"><asp:TextBox ID="txtSendAdd2" runat="server" CssClass="LargeTextBox"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        Native Country:
                                        <span class="ErrMsg" id='txtSendNativeCountry_err'>*</span>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList ID = "txtSendNativeCountry" runat = "server" style="width:134px;height:30px;"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Email:</td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtSendEmail" runat="server" CssClass="LargeTextBox"></asp:TextBox>    
                                                   
                                    </td>
                                </tr>
                                <tr>
                                    <td>Send SMS To Sender:</td>
                                    <td nowrap="nowrap">
                                        <asp:CheckBox ID="ChkSMS" runat="server"/>
                                    </td>
                                    <td>
                                        
                                    </td>
                                    <td>
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Gender:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID = "ddlSenGender" runat = "server" style="width:134px;height:30px;">
	                                        <asp:ListItem Value="">Select</asp:ListItem>
	                                        <asp:ListItem Value="Male" >Male</asp:ListItem>
	                                        <asp:ListItem Value="Female" >Female</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td id="lblMem" style="display:none">Membership ID:</td>
                                    <td id="valMem" style="display:none">
                                        <asp:TextBox ID="memberCode" runat="server" Width="130px"></asp:TextBox> 
                                        <span id="memberCode_err" class="ErrMsg"></span>
                                    </td>
                                </tr> 
                                <tr>
                                    <td colspan="4">
                                        <div id="divSenderIdImage"></div>
                                    </td>
                                </tr>  
                            </table>
                        </td>
                    </tr>
                </table>
            </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                   
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
                </div>
                <div class="modal-body">
                    <form id="employeeForm">
                        <div class="form-group">
                            <label for="Id">ID</label>
                            <input type="number" class="form-control" id="Id" name="Id" placeholder="Id" disabled="disabled"/>
                        </div>
                        <div class="form-group">
                            <label  class="control-label" for="Name">Name</label>
                            <input type="text" class="form-control" id="Name" name="Name" placeholder="Name"/>
                            </div>
                        <div class="form-group">
                            <label  class="control-label" for="Gender">Gender</label>
                            <input type="text" class="form-control" id="Gender" name="Gender" placeholder="Gender" />
                       </div>
                        <div class="form-group">
                            <label  class="control-label" for="Salary">Salary</label>
                            <input type="number" class="form-control" id="Salary" name="Salary" placeholder="Salary"/>
                        </div>
                        <div class="form-group">
                            <label  class="control-label" for="Address">Address</label>
                            <input type="text" class="form-control" id="Address" name="Address" placeholder="Address"/>
                        </div>
                          
                          <div class="form-group">
                            <label  class="control-label" for="Email">Email</label>
                            <input type="email" class="form-control" id="Email" name="Email" placeholder="Email"/>
                        </div>
                          <div class="form-group">
                            <label  class="control-label" for="Dob">Dob</label>
                            <input type="text"  class="form-control" id="Dob" name="Dob" placeholder="Dob"/>
                        </div>
                          <div class="form-group">
                            <label  class="control-label" for="Occupation">Occupation</label>
                            <input type="text" class="form-control" id="Occupation" name="Occupation" placeholder="Occupation"/>
                          </div>
                          <div class="form-group">
                            <label  class="control-label" for="IdType">IdType</label>
                            <input type="text" class="form-control" id="IdType" name="IdType" placeholder="IdType"/>
                          </div>
                          <div class="form-group">
                            <label  class="control-label" for="WalletNumber">WalletNumber</label>
                            <input type="number" class="form-control" id="WalletNumber" name="WalletNumber" placeholder="WalletNumber"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="MobileNumber">MobileNumber</label>
                            <input type="number" class="form-control" id="MobileNumber" name="MobileNumber" placeholder="MobileNumber"/>
                        </div>
                        

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="btnAdd" onclick="return Add();">Add</button>
                    <button type="submit" class="btn btn-primary" id="btnUpdate" style="display:none;" onclick="Update();">Update</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>        
    </div>
</body>
<