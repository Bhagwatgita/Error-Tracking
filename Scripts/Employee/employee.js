/// <reference path="../jquery-3.3.1.intellisense.js" />

//Load Data in Table when documents is ready
$(document).ready(function () {
    loadData();
   //loadValidator();
});
//Date Time Picker on load of page
 $( function() {
     $("#Dob").datepicker({
         beforeShow: customRange,
          mandatory: true
     });
});
function customRange(input) { 
	var date  = new  Date();
	var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();           
	return { 
			minDate: (input.id == "#Dob" ?
				$("#txtStartDate").datepicker("getDate") : 
				new Date(1969, 12,01 )), 
			maxDate: (input.id == "star.datepickerer" ? 
				$("#Dob").datepicker("getDate") : 
				new Date(y, m, d))
             };
}
//Load Data on page load
function loadData() {
    $.ajax({
        url: "/Employee/Service/EmployeeService.asmx/RetrieveAllEmployeeData",
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            var html = result.d;
            $.each(html, function (key, item) {
                html += '<tr>';
                html += '<td>' + item.Id + '</td>';
                html += '<td>' + item.Name + '</td>';
                html += '<td>' + item.Gender + '</td>';
                html += '<td>' + item.Salary + '</td>';
                html += '<td>' + item.Address + '</td>';
                html += '<td>' + item.Email + '</td>';
                html += '<td>' + item.Dob + '</td>';
                html += '<td>' + item.Occupation + '</td>';
                html += '<td>' + item.IdType + '</td>';
                html += '<td>' + item.WalletNumber + '</td>';
                html += '<td>' + item.MobileNumber + '</td>';
                html += '<td><a href="#" onclick="return getbyID(' + item.Id + ')">Edit</a> | <a href="#" onclick="Delele(' + item.Id + ')">Delete</a></td>';
                html += '</tr>';
            });
            $('.tbody').html(html);
        },
        error: function (err) {
            
            AlertMessage(err.responseText, 1);
            
        }
    });
}

//Add Data Function 
function Add() {
    //var res = validate();
    //if (res == false) {
    //    return false;
    //}
     //EnableDisableButton();
    var emp = {
        Name: $('#Name').val(),
        Gender: $('#Gender').val(),
        Salary: $('#Salary').val(),
        Address: $('#Address').val(),
        Email: $('#Email').val(),
        Dob: $('#Dob').val(),
        Occupation: $('#Occupation').val(),
        IdType: $('#IdType').val(),
        WalletNumber: $('#WalletNumber').val(),
        MobileNumber: $('#MobileNumber').val()
    };
    console.log(emp);
    
    $.ajax({
        url: "/Employee/Service/EmployeeService.asmx/SaveEmployee",
        data:  JSON.stringify({emp: emp }),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        
        success: function (result) {
            if (result.d.ErrorCode == "0") {
                AlertMessage(result.d.Msg, result.d.ErrorCode);
                loadData();
                $('#myModal').modal('hide');

            } else if(result.d.ErrorCode == "1"){
                AlertMessage(result.d.Msg, result.d.ErrorCode);
                loadData();
                $('#myModal').modal('show');
            }
            
        },
        error: function (err) {
             AlertMessage(err.responseText, 1);
        }
    });
}

$.date = function(dateObject) {
    var d = new Date(dateObject);
    var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }
    var date = year + "-" + month + "-" + day;

    return date;
};
//usage $.date(result.d.Dob)

//Function for getting the Data Based upon Employee ID
function getbyID(id) {
    //setBorderColorGrey();
   
    $.ajax({
        url: "/Employee/Service/EmployeeService.asmx/RetrieveSingleEmployee",
        type: "POST",
        data:  JSON.stringify({ id:id}),
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        success: function (result) {
            $('#Id').val(result.d.Id);
            $('#Name').val(result.d.Name);
            $('#Gender').val(result.d.Gender);
            $('#Salary').val(result.d.Salary);
            $('#Address').val(result.d.Address);
            $('#Email').val(result.d.Email);
            $('#Dob').val(result.d.Dob);
            $('#Occupation').val(result.d.Occupation);
            $('#IdType').val(result.d.IdType);
            $('#WalletNumber').val(result.d.WalletNumber);
            $('#MobileNumber').val(result.d.MobileNumber);

            $('#myModalLabel').html("Update Employee");
            $('#myModal').modal('show');
            $('#btnUpdate').show();
            $('#btnAdd').hide();
        },
        error: function (err) {
              AlertMessage(err.responseText, 1);
        }
    });
    return false;
}

//function for updating employee's record
function Update() {
    //var res = validate();
    //if (res == false) {
    //    return false;
    //}
    
    var empObj = {
        Id: $('#Id').val(),
        Name: $('#Name').val(),
        Gender: $('#Gender').val(),
        Salary: $('#Salary').val(),
        Address: $('#Address').val(),
        Email: $('#Email').val(),
        Dob: $('#Dob').val(),
        Occupation: $('#Occupation').val(),
        IdType: $('#IdType').val(),
        WalletNumber: $('#WalletNumber').val(),
        MobileNumber: $('#MobileNumber').val()
    };
    
    $.ajax({
        url: "/Employee/Service/EmployeeService.asmx/UpdateEmployee",
        data:  JSON.stringify({ emp: empObj} )  ,
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (result) {
            debugger;
            AlertMessage(result.d.Msg, result.d.ErrorCode);
            loadData();
            $('#myModal').modal('hide');
            clearObjectData();
        },
        error: function (err) {
             AlertMessage(err.responseText, 1);
        }
    });
}

//function for deleting employee's record
function Delele(Id) {
    var ans = confirm("Are you sure you want to delete this Record?");
    if (ans) {
        $.ajax({
            url: "/Employee/Service/EmployeeService.asmx/DeleteEmployees",
            type: "POST",
            data:JSON.stringify({ id:Id}),
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (result) {
                AlertMessage(result.d.Msg, result.d.Id);
                loadData();
            },
            error: function (err) {
                AlertMessage(err.responseText, 1);
                
            }
        });
    }
}
function AlertMessage(msg, msgId) {
    switch (msgId) {
        case "0":
             $.gritter.add({
                        title: '<span style="color: green;">Success</span>',
                        text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + msg + '</span>',
                        image: '/Images/success-icon.png',
                        sticky: false,
                        time: '10000'
                });
            break;
        case "1":
            $.gritter.add({
                        title: '<span style="color: red;">Failure</span>',
                        text: '<span style="color: red; font-size: 12px; font-weight: bold;">' + msg + '</span>',
                        image: '/Images/error-icon.png',
                        sticky: false,
                        time: '10000'
             });
            break;
    }

}
function clearObjectData() {
    $('#Id').val("");
    $('#Name').val("");
    $('#Gender').val("");
    $('#Salary').val("");
    $('#Address').val("");
    $('#Email').val("");
    $('#Dob').val("");
    $('#Occupation').val("");
    $('#IdType').val("");
    $('#WalletNumber').val("");
    $('#MobileNumber').val("");
    $('#myModalLabel').html("Add Employee");
}

function setBorderColorGrey() {
    $('#Name').css('border-color', 'lightgrey');
    $('#Gender').css('border-color', 'lightgrey');
    $('#Salary').css('border-color', 'lightgrey');
    $('#Address').css('border-color', 'lightgrey');
    $('#Email').css('border-color', 'lightgrey');
    $('#Dob').css('border-color', 'lightgrey');
    $('#Occupation').css('border-color', 'lightgrey');
    $('#IdType').css('border-color', 'lightgrey');
    $('#WalletNumber').css('border-color', 'lightgrey');
    $('#MobileNumber').css('border-color', 'lightgrey'); 
}

//Function for clearing the textboxes
function clearTextBox() {
    
    clearObjectData();
    $('#btnUpdate').hide();
    $('#btnAdd').show();
    //setBorderColorGrey();
}
//Validation using jquery
function validate() {
    var isValid = true;
    if ($('#Name').val().trim() == "") {
        $('#Name').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Name').css('border-color', 'lightgrey');
    }
    if ($('#Gender').val().trim() == "") {
        $('#Gender').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Gender').css('border-color', 'lightgrey');
    }
    if ($('#Salary').val().trim() == "") {
        $('#Salary').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Salary').css('border-color', 'lightgrey');
    }
    if ($('#Address').val().trim() == "") {
        $('#Address').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Address').css('border-color', 'lightgrey');
    }
    if ($('#Email').val().trim() == "") {
        $('#Email').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Email').css('border-color', 'lightgrey');
    }
    if ($('#Dob').val().trim() == "") {
        $('#Dob').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Dob').css('border-color', 'lightgrey');
    }
    if ($('#Occupation').val().trim() == "") {
        $('#Occupation').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Occupation').css('border-color', 'lightgrey');
    }
    if ($('#IdType').val().trim() == "") {
        $('#IdType').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#IdType').css('border-color', 'lightgrey');
    }
    if ($('#WalletNumber').val().trim() == "") {
        $('#WalletNumber').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#WalletNumber').css('border-color', 'lightgrey');
    }
    if ($('#MobileNumber').val().trim() == "") {
        $('#MobileNumber').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#MobileNumber').css('border-color', 'lightgrey');
    }

    return isValid;
}

//bootstrap validator
$(function () {
    
    $('#employeeForm').bootstrapValidator({
        //container: '#messages',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            Name: {
                validators: {
                    notEmpty: {
                        message: 'The Name field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 255,
                        min: 10,
                        message: 'The Name field must be greater than 10 characters long'
                    }
                }
            },
            Email: {
                validators: {
                    notEmpty: {
                        message: 'The email address is required and cannot be empty'
                    },
                    emailAddress: {
                        message: 'The email address is not valid'
                    }
                }
            },
            Gender: {
                validators: {
                    notEmpty: {
                        message: 'The Gender field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 6,
                        min: 4,
                        message: 'The Gender field must be less than 6 characters long'
                    }
                }
            },
            Salary: {
                validators: {
                    notEmpty: {
                        message: 'The Salary is required and cannot be empty'
                    },
                    stringLength: {
                        max: 10,
                        min: 4,
                        message: 'The Salary field must be greater than 4 characters long'
                    }
                }
            },
            Address: {
                validators: {
                    notEmpty: {
                        message: 'The Address field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 20,
                        min:5,
                        message: 'The Address field must be greater than 5 characters long'
                    }
                }
            },
             Dob: {
                validators: {
                    notEmpty: {
                        message: 'The Date of Birth field is required and cannot be empty'
                    }
                }
            },
             Occupation: {
                validators: {
                    notEmpty: {
                        message: 'The Occupation field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 50,
                        min:5,
                        message: 'The Occupation field must be greater than 5 characters long'
                    }
                }
            },
             IdType: {
                validators: {
                    notEmpty: {
                        message: 'The IdType field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 50,
                        min:8,
                        message: 'The IdType field must be greater than 8 characters long'
                    }
                }
            },
             WalletNumber: {
                validators: {
                    notEmpty: {
                        message: 'The WalletNumber field is required and cannot be empty'
                    },
                    stringLength: {
                        max: 10,
                        min:10,
                        message: 'The WalletNumber field must be 5 characters long'
                    }
                }
            },
            MobileNumber: {
                validators: {
                    notEmpty: {
                        message: 'The MobileNumber field is required and cannot be empty'
                    },
                    stringLength: {
                        max:10,
                        min: 10,
                        message: 'The MobileNumber field must be 10 characters long'
                    }
                }
            }


        }
        //,
        // submitHandler: function(validator, form, submitButton) {
        //     EnableDisableButton();
        // }
        //.on('success.field.fv', function(e, data) {
        //    if (data.fv.getInvalidFields().length > 0) {    // There is invalid field
        //        //data.fv.disableSubmitButtons(true);
        //        $('#btnAdd').attr('disabled', 'disabled');

        //    }
        //})
       
    
    });
});
function EnableDisableButton() {
    var x = $('.bv-hidden-submit').attr('disabled');
    
    if (x == "disabled") {
        $('#btnAdd').attr('disabled', 'disabled');
    } else {
        $('#btnAdd').removeAttr('disabled');
    }
}

$(function() {
    $('#employeeForm').on( "valid.bs.validator", function() {
        $('#btnAdd').removeClass("disabled");        // enables button
        console.log("VALID FORM");
    });

    $('#employeeForm').on( "invalid.bs.validator", function() {
        $('#btnAdd').addClass('disabled');
        console.log("INVALID FORM");
    });
});
