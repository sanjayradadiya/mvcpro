/*Set Cookie Value */
function setCookie(cookiename, value, expdays) {
    var expdate = new Date();
    expdate.setDate(expdate.getDate() + expdays);
    var c_value = escape(value) + ((expdays == null) ? "" : "; expires=" + expdate.toUTCString());
    document.cookie = cookiename + "=" + c_value + "; path=/";
}

/*Get Cookie Value */
function getCookie(cookiename) {
    var i, x, y, ARRcookies = document.cookie.split(";");
    for (i = 0; i < ARRcookies.length; i++) {
        x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
        x = x.replace(/^\s+|\s+$/g, "");
        if (x == cookiename) { return unescape(y); }
    }
}

/*set cookie by name, value*/
var rows_selected = [];
function selUpdate(obj, row, cookieNm) {
    var curid = $(row).attr('id');
    var flag = $(obj).prop('checked');

    var found = $.inArray(curid, rows_selected) > -1

    if (obj.checked && !found) { rows_selected.push(curid); }
    else { spliceElemnt(curid, rows_selected) }

    var selecteds = getCookie(cookieNm);
    if (selecteds !== undefined) {
        var CL_SELECTEDS = selecteds.split(",");
        var index = $.inArray(curid, CL_SELECTEDS);
        if (index != -1) CL_SELECTEDS.splice(index, 1);
        curSelections = (flag == true) ? CL_SELECTEDS.join(",") + ',' + curid : CL_SELECTEDS.join(",");
        curSelections != '' ? setCookie(cookieNm, curSelections, 1) : setCookie(cookieNm, '', -1);
        return false;
    }
    else {
        setCookie(cookieNm, curid, 1);
    }
}

function spliceElemnt(value, itemArray) { itemArray.splice($.inArray(value, itemArray), 1); }

/*service based ajax call*/
function raiseEvent(obj, retval) {
    SetLoadingProc();
    $.ajax({
        url: $(obj).data('request-url'), contentType: 'application/json; charset=utf-8',
        datatype: 'json', type: "POST", async: true,
        success: function (resp) {
            RemoveLoadingProc();
            if ($(obj).data('response-url') != undefined) { location.href = resp; return; }
            location.href = $(obj).data('request-url');
        },
        error: function () { RemoveLoadingProc(); SetNotify("error", "Network related issues may caused.."); }
    }).complete(function () { RemoveLoadingProc(); });
}

/*service based ajax call*/
function raiseCartEvent(obj, retval) {
    SetLoadingProc();
    $.ajax({
        url: $(obj).data('request-url'), contentType: 'application/json; charset=utf-8',
        datatype: 'json', type: "POST", async: true,
        success: function (data) {
            /*$.alert.open('confirm', data.title, data.msg, function (e) { if (e == 'yes') window.location = data.rerUtl; else window.location = window.location; });*/
            debugger;
            SetNotify("success", data.msg); window.location = data.retUrl;
        },
        error: function () { RemoveLoadingProc(); /*invokeMsg('warning', 'Error', 'Network related issues may caused..');*/ SetNotify("error", "Network related issues may caused.."); }
    }).complete(function () { RemoveLoadingProc(); });
}

function raiseMail(obj, params) {
    SetLoadingProc();
    $.ajax({
        url: $(obj).data('request-url'),
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params), datatype: 'json',
        type: "POST", async: true,
        success: function (response) {
            RemoveLoadingProc();
            if (response == "1") { /*invokeMsg('info', 'Mail', 'Mail sent successfully..');*/ SetNotify("success", "Mail has been sent Successfully.."); }
            else { /*invokeMsg('warning', 'Mail', 'Mail sent failure, Please try again..');*/ SetNotify("warning", "Mail sent failure, Please try again.."); }
        },
        error: function () { RemoveLoadingProc(); /*invokeMsg('warning', 'Error', 'Network related issues may caused..');*/ SetNotify("error", "Network related issues may caused.."); }
    }).complete(function () { RemoveLoadingProc(); });;
}

function raiseRemEvent(obj) {
    SetLoadingProc();
    $.ajax({
        url: $(obj).data('request-url'), contentType: 'application/json; charset=utf-8',
        datatype: 'json', type: "POST", data: JSON.stringify({ "carttype": $(obj).data('pagetype') }), async: true,
        success: function (data) {
            RemoveLoadingProc();
            //$.alert.open('confirm', data.title, data.msg, function (e) { if (e == 'yes') window.location = data.rerUtl; else window.location = window.location; });
            if (!data.isError) { window.location = window.location; } else { SetNotify("error", "Selected stock details not deleted, Please try again"); }
        },
        error: function () { RemoveLoadingProc(); SetNotify("error", "Network related issues may caused.."); }
    }).complete(function () { RemoveLoadingProc(); });
}

/*Number valication*/
function DecValid(evt, ent, maxlength) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    if ($(ent).val().length > maxlength) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
    if ((key < 48 || key > 57) && !(key == 8 || key == 9 || key == 13 || key == 37 || key == 39 || key == 46)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
    if (key == 46 && theEvent.charCode == 46 && $(ent).val().indexOf('.') >= 0) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
    if (key == 46 && theEvent.charCode == 46 && $(ent).val() == "") {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}

/*populate modal popup for all*/
$(".invpopup").unbind('click').on("click", function (event) {
    var popid = $(this).data("target");
    $(popid).fadeIn(300, function () {
        $(document).keyup(function (e) { if (e.keyCode == 27) $('.popupclose').click(); });
    });
    function poppos() {
        var wh = $(window).height();
        var ph = $(popid + ">" + ".popupcon").innerHeight();
        var popp = wh / 2 - ph / 2;
        if (popp <= 0) { popp = 0; }
        $(popid).find(".popupcon").fadeIn().stop(true, false).animate({ top: popp, opacity: 1 }, 400);
    }
    poppos();
    $(window).resize(poppos);
});

$(".popupclose , .cancel").unbind('click').click(function (event) {
    $(".popup").stop(true).fadeOut(400);
    $(".popupcon").stop(true).animate({ top: 0, opacity: 0 }, 400).fadeOut();
});

/*---------------------showing Loading Process */
function SetLoadingProc() {
    var overlapDiv = document.createElement("div");
    overlapDiv.id = "overlap";
    overlapDiv.style.cssText = "position:fixed;z-index:10000;top:0; right:0; width:" + 100 + "%; height:100%; opacity: 0.5; background: rgba(179, 180, 225, 0.43); text-align: center;padding-top:250px; opacity:1.5; filter:alpha(opacity=50;font-family:Verdana;color:Red;font-size:xx-small;";
    overlapDiv.innerHTML = "<img src='../../Content/Images/mg.gif' height='100px' width='100px'/>";
    document.getElementsByTagName("body")[0].appendChild(overlapDiv);
}

function RemoveLoadingProc() { $('#overlap').fadeOut('fast', function () { $('#overlap').remove(); }); }

/*---------------------notifieing messsges*/
$(document).ready(function () {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-center",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1500",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
})

/*---------------------alertify messsges*/
function invokeMsg(flag, title, message) {
    $.alert.open(flag, title, message);
}

/*---------------------set Notifier*/
function SetNotify(flag, value) {
    switch (flag) {
        case "success": toastr["success"](value); break;
        case "error": toastr["error"](value); break;
        case "warning": toastr["warning"](value); break;
    }
}