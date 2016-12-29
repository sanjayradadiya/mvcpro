/*-------------------------------------------------datatable formatting start*/
function apiTotals(api, indx) {
    var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
    total = api.column(indx).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
    pageTotal = api.column(indx, { page: 'current' }).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
    return pageTotal;
}

function setCalc(api, indx) {
    pageTotal = apiTotals(api, indx);
    $(api.column(indx).footer()).html(pageTotal.toFixed(2));
}

function setCalcAvg(api, indx, indx1, indx2) {
    pageTotal1 = 0, pageTotal2 = 0;
    pageTotal1 = apiTotals(api, indx1);
    pageTotal2 = indx2;
    var retval = pageTotal1 == 0 ? "0.00" : (pageTotal1 / pageTotal2).toFixed(2);
    //$(api.column(indx).footer()).html((pageTotal1 / pageTotal2).toFixed(2));
    $(api.column(indx).footer()).html(retval);
}

function setCalcAvg2(api, indx, indx1, indx2) {
    pageTotal1 = 0, pageTotal2 = 0;
    pageTotal1 = indx1; pageTotal2 = indx2;
    var retval = pageTotal1 == 0 ? "0.00" : (pageTotal1 / pageTotal2).toFixed(2);
    $(api.column(indx).footer()).html(retval);
}

function setCalcDisc(api, indx, indx1, aaData) {
    pageTotal1 = apiTotals(api, indx1);
    fRapTotal = 0;
    if (aaData.length > 0) {
        for (var i = 0; i < aaData.length; i++) {
            var intVal = function () { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
            fRapTotal += isNum(aaData[i][57]);
        }
    }
    pageTotal2 = fRapTotal;
    var retval = pageTotal1 == 0 ? "0.00" : (100 - (pageTotal1 * 100 / pageTotal2)).toFixed(2);
    $(api.column(indx).footer()).html(retval);
}

function isNum(num) { num = num == "" ? 0 : num; if (isNaN(num)) return 0; return parseFloat(num); }

function updateDataTableSelectAllCtrl(table) {
    var $table = table.table().node();
    var $chkbox_all = $('tbody input[type="checkbox"]', $table);
    var $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table);
    var chkbox_select_all = $('thead input[name="selectAll"]', $table).get(0);
    var chkbox_header = $('.dataTables_scrollHeadInner table thead tr input[type="checkbox"]');

    // If none of the checkboxes are checked
    if ($chkbox_checked.length === 0) {
        chkbox_select_all.checked = false;
        $(chkbox_header).prop('checked', false);
        if ('indeterminate' in chkbox_select_all) {
            chkbox_select_all.indeterminate = false;
        }

        // If all of the checkboxes are checked
    } else if ($chkbox_checked.length === $chkbox_all.length) {
        chkbox_select_all.checked = true;
        $(chkbox_header).prop('checked', true);
        if ('indeterminate' in chkbox_select_all) {
            chkbox_select_all.indeterminate = false;
        }

        // If some of the checkboxes are checked
    } else {
        chkbox_select_all.checked = false;
        $(chkbox_header).prop('checked', false);
        if ('indeterminate' in chkbox_select_all) {
            chkbox_select_all.indeterminate = true;
        }
    }
}

function formatLegends(legends) {
    var vals = legends.split(','); retval = '<div class="legends">';
    $.each(vals, function (i, value) { prm = value == '-' ? '<span class="nan">' : '<span class="' + value + '">'; retval += prm + value + '</span>'; });
    return retval + "</div>";
}

function format(d) {
    // `d` is the original data object for the row
    return '<div class="slider">' +
         '<table cellpadding="5" cellspacing="0" style="padding :4px; width:80%;padding-left:50px; border-collapse:collapse;">' +
         '<tr>' +
             '<td class="tdtitle">Colordesc</td>' + '<td>' + d[42] + '</td>' +       //Colordesc
             '<td class="tdtitle">Girdleper</td>' + '<td>' + d[26] + '</td>' +       //Girdleper
             '<td class="tdtitle">Crown</td>' + '<td>' + d[31] + '</td>' +           //Crown
             '<td class="tdtitle">StarLength</td>' + '<td>' + d[37] + '</td>' +      //StarLength
             '<td class="tdtitle">Length</td>' + '<td>' + d[44] + '</td>' +          //Length
             '<td class="tdtitle">Natts</td>' + '<td>' + d[49] + '</td>' +           //Natts
         '</tr>' + '<tr>' +
             '<td class="tdtitle">Depth</td>' + '<td>' + d[19] + '</td>' +           //Depth
             '<td class="tdtitle">GirdleCondition</td>' + '<td>' + d[27] + '</td>' + //GirdleCond
             '<td class="tdtitle">Crownangle</td>' + '<td>' + d[32] + '</td>' +      //Crownangle
             '<td class="tdtitle">LowerHalf</td>' + '<td>' + d[33] + '</td>' +       //LowerHalf
             '<td class="tdtitle">Width</td>' + '<td>' + d[45] + '</td>' +           //Width
             '<td class="tdtitle">Natural</td>' + '<td>' + d[46] + '</td>' +         //Natural
         '</tr>' + '<tr>' +
             '<td class="tdtitle">Diatable</td>' + '<td>' + d[20] + '</td>' +        //Diatable
             '<td class="tdtitle">Ha</td>' + '<td>' + d[28] + '</td>' +              //Ha
             '<td class="tdtitle">Crownheight</td>' + '<td>' + d[33] + '</td>' +     //Crownheight
             '<td class="tdtitle">KeyToSymbol</td>' + '<td>' + d[39] + '</td>' +     //KeyToSymbol
             '<td class="tdtitle">Height</td>' + '<td>' + d[46] + '</td>' +          //Height
             '<td class="tdtitle">Pair</td>' + '<td>' + d[51] + '</td>' +            //Pair
         '</tr>' + '<tr>' +
             '<td class="tdtitle">Dia</td>' + '<td>' + d[25] + '</td>' +             //Dia
             '<td class="tdtitle">Inclusion</td>' + '<td>' + d[29] + '</td>' +       //Inclusion
             '<td class="tdtitle">Fl. Color</td>' + '<td>' + d[40] + '</td>' +       //Fl. Color
             '<td class="tdtitle">Luster</td>' + '<td>' + d[47] + '</td>' +          //Luster
             '<td class="tdtitle">Ratio</td>' + '<td>' + d[62] + '</td>' +           //Ratio
             '<td class="tdtitle"></td>' + '<td></td>' +                             //Colordesc
         '</tr>' + '<tr>' +
             '<td class="tdtitle">Inscription</td>' + '<td>' + d[24] + '</td>' +     //Inscription
             '<td class="tdtitle">Pavheight</td>' + '<td>' + d[36] + '</td>' +       //Pavheight
             '<td class="tdtitle">Pavangle</td>' + '<td>' + d[37] + '</td>' +        //Pavangle
             '<td class="tdtitle">Culet</td>' + '<td>' + d[41] + '</td>' +           //Culet
             '<td class="tdtitle">Milky</td>' + '<td>' + d[48] + '</td>' +           //Milky
             '<td class="tdtitle">Shade</td>' + '<td>' + d[49] + '</td>' +           //Shade
         '</tr>' +
     '</table>';
}

function formattotals(d, length) {
    // `d` is the original data object for the row
    //return '<div class="col-xs-12 col-sm-2"><b>Grand Totals</b></div>' +
    //'<div class="col-sm-2">Stones :' + length + '</div>' +
    //'<div class="col-sm-2">Cts :' + d.Cts + '</div>' +
    //'<div class="col-sm-2">$/Cts :' + d.Rate + '</div>' +
    //'<div class="col-sm-2">Discount :' + d.Disc + '</div>' +
    //'<div class="col-sm-2">Amount :' + d.Amount + '</div>';

    if (typeof (d) == undefined || d == null) { return ''; }

   // return '<ul class="nav nav-pills nav-justified"><li class="btn"><b>Grand Totals</b></li>' +
   //'<li class="btn">Stones :' + length + '</li>' +
   //'<li class="btn">Cts :' + d.Cts + '</li>' +
   //'<li class="btn">$/Cts :' + d.Rate + '</li>' +
   //'<li class="btn">Discount :' + d.Disc + '</li>' +
   //'<li class="btn">Amount :' + d.Amount + '</li>' +
    //'</ul>';

    return '<div class="grtotals"><div class="col-xs-12 col-sm-2" style="color:#5e60b2;">Grand Total </div>' +
    '<div class="col-sm-2 col-xs-6">Stones :' + length + '</div>' +
    '<div class="col-sm-2 col-xs-6">Cts :' + d.Cts + '</div>' +
    '<div class="col-sm-2 col-xs-6">$/Cts :' + d.Rate + '</div>' +
    '<div class="col-sm-2 col-xs-6">Discount :' + d.Disc + '</div>' +
    '<div class="col-sm-2 col-xs-12">Amount :' + d.Amount + '</div></div>';
}

/*-------------------------------------------------datatable selection summary start*/
//$(document).on('change', '#grview tbody tr .checkbox', function (e) {
//    var currow = $(this).closest('tr');
//    console.log($(currow).attr('id'));
//    console.log($('td', currow).eq(6).html());
//});

/*Custom calculation of selected stock live updates*/
var rows_selected = [], cts_sel = [], amt_sel = [], ramt_sel = [];
function curCalc(obj, currow) {
    var rowId = $(currow).attr("id");
    var found = $.inArray(rowId, rows_selected) > -1
    if (obj.checked && !found) {
        rows_selected.push(rowId);
        cts_sel.push(isNum($('td', currow).eq(8).html()));
        amt_sel.push(isNum($('td', currow).eq(18).html()));
        ramt_sel.push(isNum($('td', currow).find('input[name="checkinv"]').attr('data-framt')));
    }
    else {
        spliceElemnt(rowId, rows_selected)
        spliceElemnt(isNum($('td', currow).eq(8).html()), cts_sel)
        spliceElemnt(isNum($('td', currow).eq(18).html()), amt_sel)
        spliceElemnt(isNum($('td', currow).find('input[name="checkinv"]').attr('data-framt')), ramt_sel)
    }

    stCts = cts_sel.length > 0 ? cts_sel.reduce(getSum).toFixed(2) : '0.00';
    stAmt = amt_sel.length > 0 ? amt_sel.reduce(getSum).toFixed(2) : '0.00';
    stRamt = ramt_sel.length > 0 ? ramt_sel.reduce(getSum).toFixed(2) : '0.00';
    stRate = amt_sel.length > 0 ? (isNaN(stAmt / stCts) == false ? (stAmt / stCts).toFixed(2) : 0) : '0.00';
    //stRapo = (stRamt / stCts).toFixed(2);
    stDisc = isNaN(stAmt * 100 / stRamt) ? '0.00' : (100 - (stAmt * 100 / stRamt)).toFixed(2);

    $('#spStones').html(rows_selected.length);
    $('#spCts').html(stCts);
    $('#spRate').html(stRate);
    $('#spDisc').html(stDisc);
    $('#spAmt').html(stAmt);

    /*gatheing selected refno on cookie*/
    invSelUpdate(rowId, obj.checked);
}

/*selected stock live updating from cookie */
function invSelUpdate(curid, flag) {
    var selecteds = getCookie('CK_SELECTEDS');
    if (selecteds !== undefined) {
        var CK_SELECTEDS = selecteds.split(",");
        var index = $.inArray(curid, CK_SELECTEDS);
        if (index != -1) CK_SELECTEDS.splice(index, 1);
        curSelections = (flag == true) ? CK_SELECTEDS.join(",") + ',' + curid : CK_SELECTEDS.join(",");
        curSelections != '' ? setCookie("CK_SELECTEDS", curSelections, 1) : setCookie("CK_SELECTEDS", '', -1);
        return false;
    }
    else {
        setCookie("CK_SELECTEDS", curid, 1);
    }
}

function getSum(total, num) { return total + num; }
function isNum(num) { num = num == "" ? 0 : num; if (isNaN(num)) return 0; return parseFloat(num); }
function spliceElemnt(value, itemArray) { itemArray.splice($.inArray(value, itemArray), 1); }

/*results export/mail/confirmation of all events*/
function getCurrentselection() {
    var selecteds = getCookie('CK_SELECTEDS');
    if (selecteds !== undefined) { var CK_SELECTEDS = selecteds.split(","); if (CK_SELECTEDS.length > 0) return true; }
    else { return false; }
}

$('#ExportToExcel').click(function () {
    var retval = getCurrentselection();
    if (retval === false) { var conf = confirm('Do you want to download all inventory results..?'); if (conf === false) return false; }
    raiseEvent(this, null);
});

$('#AddtoCart').click(function () {
    var retval = getCurrentselection();
    if (retval === false) { alert('Please select atleast one to add cart..'); return false; }
    raiseCartEvent(this, null);
});

$('#AddtoBuyReq').click(function () {
    var retval = getCurrentselection();
    if (retval === false) { alert('Please select atleast one to add cart..'); return false; }
    raiseCartEvent(this, null);
});

$('#CompareStone').click(function () {
    var retval = getCurrentselection();
    if (retval === false) { alert('Please select more than one Stock Id..'); return false; }
    else {
        var selecteds = getCookie('CK_SELECTEDS'); var CK_SELECTEDS = selecteds.split(",");
        if (CK_SELECTEDS.length > 1) { window.open($(this).data('request-url'), '_blank'); }
        else { alert('Please select more than one Compare stock..'); return false; }
    }
});

$('#DelStock').click(function () {
    var retval = getCurrentselection();
    if (retval === false) { alert('Please select atleast one to remove..'); return false; }
    raiseRemEvent(this);
});

$(".popupinvclk").on("click", function (event) {
    var retval = getCurrentselection();
    if (retval === false) {
        var conf = confirm('Do you want to mail all inventory results..?');
        if (conf === false) return false;
    }

    var popid = $(this).attr("show-popup");
    $(popid).fadeIn(300, function () {
        $(document).keyup(function (e) {
            if (e.keyCode == 27) $('.popupclose').click();
        });
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

$('#btnSend').on('click', function () {
    var params = { 'To': $('#EmailId').val(), 'Subject': $('#Subject').val(), 'Message': $('#Message').val() };
    var retval = getCurrentselection();
    if (retval === false) {
        var conf = confirm('Do you want to mail all inventory results..?');
        if (conf === false) return false;
    }
    raiseMail(this, params);
});

$('#ModifySearch').on('click', function () { raiseEvent(this, null); });

$('#NewSearch').on('click', function () { raiseEvent(this, null); });

$('#OpenCloseDets').on('click', function () {
    var tabid = $(this).data('srctable'); var flag = $(this).hasClass("actived"); flag == false ? $(this).addClass("actived") : $(this).removeClass("actived");
    $(tabid + " tbody tr").each(function () { if (!$(this).hasClass("shown") && flag == false) { $(this).find('td.details-control').trigger('click'); } else { if (flag) { $(this).find('td.details-control').trigger('click'); } } });
});