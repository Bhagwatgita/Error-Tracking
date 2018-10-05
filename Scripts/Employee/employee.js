/// <reference path="../jquery-3.3.1.intellisense.js" />

//Load Data in Table when documents is ready
$(document).ready(function () {
    loadData();
});

//Load Data function
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
        error: function (errormessage) {
            
             $.gritter.add({
                    title: '<span style="color: red;">Failure</span>',
                    text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + errormessage.responseText + '</span>',
                    sticky: false,
                    time: '10000'
             });
            
        }
    });
}

//Add Data Function 
function Add() {
    //var res = validate();
    //if (res == false) {
    //    return false;
    //}
    var emp = {
        //Id: $('#EmployeeID').val(),
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
    alert(JSON.stringify({emp: emp }));
    $.ajax({
        url: "/Employee/Service/EmployeeService.asmx/SaveEmployee",
        data:  JSON.stringify({emp: emp }),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        
        success: function (result) {
             $.gritter.add({
                title: '<span style="color: green;">Success</span>',
                text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + result.d.Msg + '</span>',
                sticky: false,
                time: '10000'
                   
             });
            
            loadData();
            $('#myModal').modal('hide');
        },
        error: function (errormessage) {
              $.gritter.add({
                    title: '<span style="color: red;">Failure</span>',
                    text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + errormessage.responseText + '</span>',
                    sticky: false,
                    time: '10000'
             });
        }
    });
}
//function getbyID(id) {
//    var settings = {
//  "async": true,
//  "crossDomain": true,
//  "url": "/Employee/Service/EmployeeService.asmx/RetrieveSingleEmployee",
//  "method": "POST",
//  "headers": {
//    "Content-Type": "application/json",
//    "Cache-Control": "no-cache",
//    "Postman-Token": "b6c372b5-9f2a-46d4-a99d-c1ba44807486"
//  },
//  "processData": false,
//  "data": "{\n\"id\":\"2\"\n}\n\t\n   \n"
//}

//$.ajax(settings).done(function (result) {
//    console.log(result);
//     $('#Id').val(result.d.Id);
//            $('#Name').val(result.d.Name);
//            $('#Gender').val(result.d.Gender);
//            $('#Salary').val(result.d.Salary);
//            $('#Address').val(result.d.Address);
//            $('#Email').val(result.d.Email);
//            $('#Dob').val(result.d.Dob);
//            $('#Occupation').val(result.d.Occupation);
//            $('#IdType').val(result.d.IdType);
//            $('#WalletNumber').val(result.d.WalletNumber);
//            $('#MobileNumber').val(result.d.MobileNumber);

//            $('#myModal').modal('show');
//            $('#btnUpdate').show();
//            $('#btnAdd').hide();

//});
//}

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
//Function for getting the Data Based upon Employee ID
function getbyID(id) {
    setBorderColorGrey();
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
            $('#Dob').attr("value",$.date(result.d.Dob));
            $('#Occupation').val(result.d.Occupation);
            $('#IdType').val(result.d.IdType);
            $('#WalletNumber').val(result.d.WalletNumber);
            $('#MobileNumber').val(result.d.MobileNumber);

            $('#myModalLabel').html("Update Employee");
            $('#myModal').modal('show');
            $('#btnUpdate').show();
            $('#btnAdd').hide();
        },
        error: function (errormessage) {
             $.gritter.add({
                    title: '<span style="color: red;">Failure</span>',
                    text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + errormessage.responseText + '</span>',
                    sticky: false,
                    time: '10000'
             });
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
            
            $.gritter.add({
                title: '<span style="color: #3c763d;background-color: #dff0d8;border-color: #d6e9c6;">Success</span>',
                text: '<span style="color: #3c763d;background-color: #dff0d8;border-color: #d6e9c6;font-size: 12px; font-weight: bold;">' + result.d.Msg + '</span>',
                sticky: false,
                time: '10000'
                   
             });
            loadData();
            $('#myModal').modal('hide');
            clearObjectData();
        },
        error: function (errormessage) {
             $.gritter.add({
                    title: '<span style="color: red;">Failure</span>',
                    text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + errormessage.responseText + '</span>',
                    sticky: false,
                    time: '10000'
             });
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
                 $.gritter.add({
                   title: '<span style="color: green;">Success</span>',
                   text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + result.d.Msg + '</span>',
                   sticky: false,
                   time: '10000'
             });
                loadData();
            },
            error: function (errormessage) {
                  $.gritter.add({
                    title: '<span style="color: red;">Failure</span>',
                    text: '<span style="color: green; font-size: 12px; font-weight: bold;">' + errormessage.responseText + '</span>',
                    sticky: false,
                    time: '10000'
             });
            }
        });
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
    setBorderColorGrey();
}
//Valdidation using jquery
function validate() {
    var isValid = true;
    if ($('#Name').val().trim() == "") {
        $('#Name').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Name').css('border-color', 'lightgrey');
    }
    if ($('#Age').val().trim() == "") {
        $('#Age').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Age').css('border-color', 'lightgrey');
    }
    if ($('#State').val().trim() == "") {
        $('#State').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#State').css('border-color', 'lightgrey');
    }
    if ($('#Country').val().trim() == "") {
        $('#Country').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Country').css('border-color', 'lightgrey');
    }
    return isValid;
}