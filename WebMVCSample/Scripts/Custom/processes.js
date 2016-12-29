function validateForm() {
    var grp = $('#mProcGrp').val(); var prnm = $('#mPrcNm').val(); var shrtNm = $('#mPrcShortNm').val();
    var pOrd = $('#mPrcOrd').val(); var pst = $('#mPrcStatus').val(); c = 0;
    if (grp == '') { $('#mProcGrp').attr('required', 'required'); c++; } else { $('#mProcGrp').removeAttr('required'); }
    if (prnm == '') { $('#mPrcNm').attr('required', 'required'); c++; } else { $('#mPrcNm').removeAttr('required'); }
    if (shrtNm == '') { $('#mPrcShortNm').attr('required', 'required'); c++; } else { $('#mPrcShortNm').removeAttr('required'); }
    if (pOrd == '') { $('#mPrcOrd').attr('required', 'required'); c++; } else { $('#mPrcOrd').removeAttr('required'); }
    if (pst == '') { $('#mPrcStatus').attr('required', 'required'); c++; } else { $('#mPrcStatus').removeAttr('required'); }
    if (c > 0) { return false; }
    else return true;
}

function procDets(obj) {
    var currow = $(obj).closest('tr'); var rowId = $(currow).attr('id');
    $('#frmProc')[0].reset(); $("#mProcEvent").val("1"); $('#mProcGrp').val($(currow).find('td:nth-child(3)').html());
    $("#PrcId").val(rowId); $('#mProcGrp').attr('disabled', true).addClass('prcDisable');
    $('#mPrcNm').val($(currow).find('td:nth-child(4)').html()); $('#mPrcShortNm').val($(currow).find('td:nth-child(5)').html());
    $('#mPrcOrd').val($(currow).find('td:nth-child(6)').html()); $('#mPrcStatus').val($(currow).find('td:nth-child(7)').html());
    callPopup(); validateForm();
}

function prodDel(obj) {
    var currow = $(obj).closest('tr'); var rowId = $(currow).attr('id');
    var ret = confirm('Are you sure to remove this Process details'); if (ret == false) return false;
    var ProcGrp = $(currow).find('td:nth-child(3)').html(); var PrcNm = $(currow).find('td:nth-child(4)').html();
    $("#mProcEvent").val("2"); var PrcShrtNm = $(currow).find('td:nth-child(5)').html();
    var PrcId = rowId; var prcOrd = $(currow).find('td:nth-child(6)').html(); var PrcStatus = $(currow).find('td:nth-child(7)').html();
    $.ajax({
        url: '/Process/HandleProcesses', type: 'POST', datatype: 'JSON',
        data: "mProcGrp=" + ProcGrp + "&mPrcNm=" + PrcNm + "&mPrcShortNm=" + mPrcShortNm +
            "&mPrcOrd=" + prcOrd + "&PrcId=" + PrcId + "&mPrcStatus=" + PrcStatus + '&procflag=' + $("#mProcEvent").val(),
        success: function (data) { if (!data.isError) { $('#frmProc')[0].reset(); alert(data.msg); $('#ProcessGrp').change(); } else { alert(data.msg); } },
        error: function () { alert('Something went wrong..'); }
    });
}

function callPopup() {
    var popid = $("#procModal");
    $(popid).fadeIn(300, function () { $(document).keyup(function (e) { if (e.keyCode == 27) $('.popupclose').click(); }); });
    function poppos() {
        var wh = $(window).height(); var ph = $(popid).find('.popupcon').innerHeight(); var popp = wh / 2 - ph / 2; if (popp <= 0) { popp = 0; }
        $(popid).find(".popupcon").fadeIn().stop(true, false).animate({ top: popp, opacity: 1 }, 400);
    } poppos(); $(window).resize(poppos);
}