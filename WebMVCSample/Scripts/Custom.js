$(function () {
    $('#shapes>.shapes').click(function () { $(this).hasClass('nav-li-active') ? $(this).removeClass('nav-li-active') : $(this).addClass('nav-li-active'); });
    $('[data-toggle="tooltip"]').tooltip();

    $('#FrmColor').change(function () { $('#ToColor').val($('#FrmColor').val()); });
    $('#FrmClarity').change(function () { $('#ToClarity').val($('#FrmClarity').val()); });
    $('#FrmCut').change(function () { $('#ToCut').val($('#FrmCut').val()); });
    $('#FrmPolish').change(function () { $('#ToPolish').val($('#FrmPolish').val()); });
    $('#FrmSym').change(function () { $('#ToSym').val($('#FrmSym').val()); });
    $('#FrmFl').change(function () { $('#ToFl').val($('#FrmFl').val()); });
    $('#FrmGirdle').change(function () { $('#ToGirdle').val($('#FrmGirdle').val()); });
    $('#FrmCulet').change(function () { $('#ToCulet').val($('#FrmCulet').val()); });

    /*parent checkbox handlers*/
    $('#amColor li').click(function () { modelSelectors(this, 'dmColor'); });
    $('#amClarity li').click(function () { modelSelectors(this, 'dmClarity'); });
    $('#amCut li').click(function () { modelSelectors(this, 'dmCut'); });
    $('#amPolish li').click(function () { modelSelectors(this, 'dmPolish'); });
    $('#amSym li').click(function () { modelSelectors(this, 'dmSym'); });
    $('#amFl li').click(function () { modelSelectors(this, 'dmFl'); });

    /*child checkbox handlers*/
    $('#dmColor li').click(function () { childModelSelector(this, 'dmColor', 'amColor'); });
    $('#dmClarity li').click(function () { childModelSelector(this, 'dmClarity', 'amClarity'); });
    $('#dmCut li').click(function () { childModelSelector(this, 'dmCut', 'amCut'); });
    $('#dmPolish li').click(function () { childModelSelector(this, 'dmPolish', 'amPolish'); });
    $('#dmSym li').click(function () { childModelSelector(this, 'dmSym', 'amSym'); });
    $('#dmFl li').click(function () { childModelSelector(this, 'dmFl', 'amFl'); });

});

function modelSelectors(selectortype, associated) {
    if ($(selectortype).hasClass('btn-primary')) { $(selectortype).removeClass('btn-primary'); $('#' + associated + ' li').removeClass('btn-primary'); }
    else { $(selectortype).addClass('btn-primary'); $('#' + associated + ' li').addClass('btn-primary'); }
}

function childModelSelector(curObj, associated, selectortype) {
    var maxlen = $('#' + associated + ' li').length;
    $(curObj).hasClass('btn-primary') ? $(curObj).removeClass('btn-primary') : $(curObj).addClass('btn-primary');
    var minlen = $('#' + associated + ' .btn-primary').length;
    if (maxlen == minlen) { $('#' + selectortype + ' li').addClass('btn-primary'); }
    else { $('#' + selectortype + ' li').removeClass('btn-primary'); }
}

function SetMultiCtsFields(value) {
    return '<div class="col-sm-4 col-xs-4">'
                + '<input name="txtdp1" type="text" style="width: 62px;" class="form-control" onkeypress = "validateDeci(event,this)" />'
            + '</div>'
            + '<div class="col-sm-4 col-xs-4">'
                + '<input name="txtdp2" type="text" style="width: 62px;" class="form-control" onkeypress = "validateDeci(event,this)" onblur="chkPreVal(this,\'txtdp1\')" />'
            + '</div>'
            + '<div class="col-sm-1 col-xs-1">'
                + '<input type="button" value="+" class="btn" onclick="AddTextBox()" />'
            + '</div>'
            + '<div class="col-sm-1 col-xs-1"></div>'
            + '<div class="col-sm-1 col-xs-1">'
                + '<input type="button" value="x" class="btn" onclick="RemoveTextBox(this)" />'
            + '</div>'
}

function AddTextBox() {
    var div = document.createElement('DIV');
    div.style.paddingBottom = "17%";
    div.className = 'invtextdiv';
    div.innerHTML = SetMultiCtsFields("");
    document.getElementById("multiTextBoxContainer").appendChild(div);
}

function RemoveTextBox(div) {
    document.getElementById("multiTextBoxContainer").removeChild(div.parentNode.parentNode);
}

function chkPreVal(obj, agtxt) {
    _row = $(obj).closest('.invtextdiv');
    pretxt = $(_row).find('input[name="' + agtxt + '"]');
    preval = parseFloat($(pretxt).val());
    curval = $(obj).val();
    if (curval < preval) { $(obj).addClass('alertinput'); $(obj).val(parseFloat($(pretxt).val()) + 1); }
    else { if ($(obj).hasClass('alertinput')) $(obj).removeClass('alertinput'); }
}

function validateDeci(evt, ent) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
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

function invokeParams() {
    /*------Shapes*/
    sShapes = $('#shapes>.shapes.nav-li-active').map(function () { return this.id }).get().join(',');
    /*------Carats*/
    fcts = $('#FrmCts').val(); tcts = $('#ToCts').val();
    mCts1 = $('#TextBoxContainer :text').map(function () { return this.value }).get().join(',');
    mCts2 = $('#multiTextBoxContainer :text').map(function () { return this.value }).get().join(',');
    mCts = ''; if (mCts1 != ',' || mCts2 != '') { mCts = $('.invtextdiv').map(function () { return $(this).attr('name').replace(' - ', '-') }).get().join('^'); }

    /*------Color*/
    fColor = $('#FrmColor :selected').attr('seq'); tColor = $('#ToColor :selected').attr('seq');
    fColorPrm = $('#FrmColor :selected').val(); tColorPrm = $('#ToColor :selected').val();
    mColor = $('#MColor li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Clarity*/
    fClarity = $('#FrmClarity :selected').attr('seq'); tClarity = $('#ToClarity :selected').attr('seq');
    fClarityPrm = $('#FrmClarity :selected').val(); tClarityPrm = $('#ToClarity :selected').val();
    mClarity = $('#MClarity li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Cut*/
    /*fCut = FrmCut.value; tCut = ToCut.value;*/
    fCut = $('#FrmCut :selected').attr('seq'); tCut = $('#ToCut :selected').attr('seq');
    fCutPrm = $('#FrmCut :selected').val(); tCutPrm = $('#ToCut :selected').val();
    mCut = $('#MCut li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Polish*/
    //fPolish = FrmPolish.value; tPolish = ToPolish.value;
    fPolish = $('#FrmPolish :selected').attr('seq'); tPolish = $('#ToPolish :selected').attr('seq');
    fPolishPrm = $('#FrmPolish :selected').val(); tPolishPrm = $('#ToPolish :selected').val();
    mPolish = $('#MPolish li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Sym*/
    //fSym = FrmSym.value; tSym = ToSym.value;
    fSym = $('#FrmSym :selected').attr('seq'); tSym = $('#ToSym :selected').attr('seq');
    fSymPrm = $('#FrmSym :selected').val(); tSymPrm = $('#ToSym :selected').val();
    mSym = $('#MSym li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Flourescence*/
    //fFl = FrmFl.value; tFl = ToFl.value;
    fFl = $('#FrmFl :selected').attr('seq'); tFl = $('#ToFl :selected').attr('seq');
    fFlPrm = $('#FrmFl :selected').val(); tFlPrm = $('#ToFl :selected').val();
    mFl = $('#MFl li.btn-primary').map(function () { return $(this).attr('seq') }).get().join(',');
    /*------Girdle*/
    //fGirdle = FrmGirdle.value; tGirdle = ToGirdle.value;
    fGirdle = $('#FrmGirdle :selected').attr('seq'); tGirdle = $('#ToGirdle :selected').attr('seq');
    fGirdlePrm = $('#FrmGirdle :selected').val(); tGirdlePrm = $('#ToGirdle :selected').val();
    /*------Culet*/
    //fCulet = FrmCulet.value; tCulet = ToCulet.value;
    fCulet = $('#FrmCulet :selected').attr('seq'); tCulet = $('#ToCulet :selected').attr('seq');
    fCuletPrm = $('#FrmCulet :selected').val(); tCuletPrm = $('#ToCulet :selected').val();
    /*------Location*/
    fLocation = FrmLocation.value;
    /*------Lab*/
    fCertificate = FrmCertificate.value;
    /*------StoneNo*/
    fStoneNo = FrmStoneNo.value;
    /*------CertiNo*/
    fCertNo = FrmCertNo.value;
    /*------$/Cts*/
    fRate = FrmRate.value; tRate = ToRate.value;
    /*------Rap($)*/
    fRapa = FrmRapa.value; tRapa = ToRapa.value;
    /*------Amt($)*/
    fAmt = FrmAmt.value; tAmt = ToAmt.value;
    /*-----Table%*/
    fTablePer = FrmTablePer.value; tTablePer = ToTablePer.value;
    /*------Depth%*/
    fDepthPer = FrmDepthPer.value; tDepthPer = ToDepthPer.value;
    /*------Length*/
    fLength = FrmLength.value; tLength = ToLength.value;
    /*-----Width*/
    fWidth = FrmWidth.value; tWidth = ToWidth.value;
    /*-----Height*/
    fHeight = FrmHeight.value; tHeight = ToHeight.value;
    /*-----Ratio*/
    fRatio = FrmRatio.value; tRatio = ToRatio.value;
    /*-----ShowOnly*/
    fShowOnly = FrmShowOnly.value;

    ret = [];
    formatParams('Shape', sShapes);
    //if ( 1 != ',') { mlCts = mCts1 != '' & mCts2 != '' ? mCts1 + ',' + mCts2 : mCts1 != "" ? mCts1 : mCts2 != "" ? + ',' + mCts2 : ''; }
    //else { mlCts = '' };

    formatParams('Weight', fcts, tcts); formatParams('mWeight', mCts); formatParams('Col', fColor, tColor);
    formatParams('mCol', mColor); formatParams('Clr', fClarity, tClarity); formatParams('mClr', mClarity);
    formatParams('Cut', fCut, tCut); formatParams('mCut', mCut); formatParams('Pol', fPolish, tPolish);
    formatParams('mPol', mPolish); formatParams('Sym', fSym, tSym); formatParams('mSym', mSym);
    formatParams('Fl', fFl, tFl); formatParams('mFl', mFl); formatParams('Girdle', fGirdle, tGirdle);
    formatParams('Culet', fCulet, tCulet); formatParams('Table', fTablePer, tTablePer); formatParams('Depth', fDepthPer, tDepthPer);
    formatParams('Location', fLocation); formatParams('Lab', fCertificate); formatParams('Rate', fRate, tRate); formatParams('Rapo', fRapa, tRapa);
    formatParams('StoneNo', fStoneNo); formatParams('CertNo', fCertNo); formatParams('Amt', fAmt, tAmt); formatParams('Ratio', fRatio, tRatio);
    formatParams('Length', fLength, tLength); formatParams('Width', fWidth, tWidth); formatParams('Height', fHeight, tHeight); formatParams('ShowOnly', fShowOnly, '');

    srcparams = [];
    searchParams('Shape', sShapes);
    //if (mCts1 != ',') { mlCts = mCts1 != '' & mCts2 != '' ? mCts1 + ',' + mCts2 : mCts1 != "" ? mCts1 : mCts2 != "" ? mCts2 : ''; } else { mCts1 = '' };
    searchParams('Weight', fcts, tcts); searchParams('Weight', mCts); searchParams('Color', fColorPrm, tColorPrm);
    searchParams('Color', mColor); searchParams('Clarity', fClarityPrm, tClarityPrm); searchParams('Clarity', mClarity);
    searchParams('Cut', fCutPrm, tCutPrm); searchParams('Cut', mCut); searchParams('Polish', fPolishPrm, tPolishPrm);
    searchParams('Polish', mPolish); searchParams('Sym', fSymPrm, tSymPrm); searchParams('Sym', mSym);
    searchParams('Flourence', fFlPrm, tFlPrm); searchParams('Flourence', mFl); searchParams('Girdle', fGirdlePrm, tGirdlePrm);
    searchParams('Culet', fCuletPrm, tCuletPrm); searchParams('Table', fTablePer, tTablePer); searchParams('Depth', fDepthPer, tDepthPer);
    searchParams('Location', fLocation); searchParams('Lab', fCertificate); searchParams('Rate', fRate, tRate);
    searchParams('Rapo', fRapa, tRapa); searchParams('Length', fLength, tLength); searchParams('Width', fWidth, tWidth); searchParams('Height', fHeight, tHeight);
    searchParams('Amt', fAmt, tAmt); searchParams('Ratio', fRatio, tRatio); searchParams('StoneNo', fStoneNo); searchParams('CertNo', fCertNo); searchParams('ShowOnly', fShowOnly, '');

    for (x in srcparams) { if (srcparams[x] instanceof Array) { srcparams[x] = srcparams[x].join(": "); } }
}

$('#btnsearch').on('click', function () {
    SetLoadingProc(); invokeParams(); var srcParamStr = srcparams.join(";");
    $.ajax({
        url: "/InventorySearch/Index", type: 'POST', contentType: 'application/json', data: JSON.stringify({ invokers: ret, srcparam: srcParamStr }),
        success: function (data) { location.href = "/InventoryResults"; }
    }).complete(function () { RemoveLoadingProc(); });
    return true;
});

$('#btnreset').on('click', function () { $.ajax({ url: $(this).data('request-url'), type: 'POST', datatype: 'json', async: true, success: function (data) { location.href = data; }, error: function () { RemoveLoadingProc(); } }); });

function validSrcName() { var ret = true; _src = $('#SearchName').val(); if (_src == '') { $(_src).focus(); $('.msg').html('Search Name Could Not be Blank..'); ret = false; } else { $('.msg').html(''); ret = true; } return ret; }

$('#btnSaveSrc').on('click', function () {
    ret = validSrcName(); if (!ret) return false;
    SetLoadingProc(); invokeParams();
    $.ajax({
        url: "/InventorySearch/SaveSearch", type: 'POST', contentType: 'application/json',
        data: JSON.stringify({ invokers: ret, srcname: $('#SearchName').val() }),
        success: function (data) { if (parseInt(data) == -1) { $('.msg').html('Your favourite to add did not saved'); } else { $('.popupclose').click(); } },
        error: function () { $('.msg').html('Your favourite to add did not saved'); }
    }).complete(function () { RemoveLoadingProc(); });
    return true;
});

$('#SavedList').on('change', function () {
    var args = { "sid": $(this).val(), "sname": $('#SavedList :selected').text() }; SetLoadingProc();
    $.ajax({
        url: 'InventorySearch/SetSavedList', type: 'POST', datatype: 'json', data: args,
        success: function (data) { if (data.retval == "0") $('#btnreset').click(); else { callback(data.Results); } },
        error: function (data) { console.log(data) }
    }).complete(function () { RemoveLoadingProc(); });
});

var ret, srcparams;
function formatParams(obj, gen1, gen2) {
    if ((typeof (gen1) != 'undefined' && typeof (gen2) != 'undefined') && (gen1 != '' && gen2 != '')) { ret.push([obj, gen1 + "," + gen2]); return; }
    if (typeof (gen1) != 'undefined' && gen1 != '') { ret.push([obj, gen1]); return; }
}

function searchParams(obj, gen1, gen2) {
    if ((typeof (gen1) != 'undefined' && typeof (gen2) != 'undefined') && (gen1 != '' && gen2 != ''))
    { srcparams.push([obj, gen1 + "-" + gen2]); return; }
    if (typeof (gen1) != 'undefined' && gen1 != '')
    { srcparams.push([obj, gen1]); return; }
}

/*multi selectors from popup modals */
var arrCts = [], arrColor = [], arrClr = [], arrCut = [], arrPol = [], arrSym = [], arrFlr = [];

$('#btnMCts').on('click', function () { arrCts = []; SetMultiCts('MCts'); $('.popupclose').click(); });
$('#btnMCol').on('click', function () { arrColor = []; SetMultiSelections('MColor', 'divCol', arrColor); $('.popupclose').click(); });
$('#btnMClr').on('click', function () { arrClr = []; SetMultiSelections('MClarity', 'divClr', arrClr); $('.popupclose').click(); });
$('#btnMCut').on('click', function () { arrCut = []; SetMultiSelections('MCut', 'divCut', arrCut); $('.popupclose').click(); });
$('#btnMPol').on('click', function () { arrPol = []; SetMultiSelections('MPolish', 'divPol', arrPol); $('.popupclose').click(); });
$('#btnMSym').on('click', function () { arrSym = []; SetMultiSelections('MSym', 'divSym', arrSym); $('.popupclose').click(); });
$('#btnMFl').on('click', function () { arrFlr = []; SetMultiSelections('MFl', 'divFl', arrFlr); $('.popupclose').click(); });

function SetMultiSelections(objId, divId, objValArr) {
    var strCont = '';
    $('#' + objId + ' li').each(function () { if ($(this).hasClass('btn-primary')) { objValArr.push($(this).html()); } });
    if (objValArr.length > 0) {
        if ($('.' + divId).find('.invtoggles').length > 0) { $('.' + divId).find('.invtoggles').remove(); }
        var strCont = '<div class="invtoggles">';
        $.each(objValArr, function (index, value) { strCont = strCont + '<div>' + value + '<a class="delete" popfrom="' + objId + '" size="' + value + '" href="javascript:void(0);"><i class="fa fa-close"></i></a></div>'; });
        strCont = strCont + '</div>';
        $('select', '.' + divId).each(function () { $(this).prop('selectedIndex', 0) });
        $('.' + divId + ' div, .' + divId + ' span').hide();
        $('.' + divId + ' button').before(strCont);
    }
    else {
        $('.' + divId + ' div, .' + divId + ' span').show();
        $('.' + divId + ' .invtoggles').remove()
    }
}

function SetMultiCts(objId) {
    var txtval1, txtval2;
    if ($('#TextBoxContainer input[name="txt1"]').val() != "" && $('#TextBoxContainer input[name="txt2"]').val() != "") {
        txtval1 = parseFloat($('#TextBoxContainer input[name="txt1"]').val());
        txtval2 = parseFloat($('#TextBoxContainer input[name="txt2"]').val()); clval = txtval1 + ' - ' + txtval2; arrCts.push(clval);
        $('#TextBoxContainer').attr('name', clval);
    }
    $('#TextBoxContainer :text').map(function () { return this.value }).get().join(' - ');
    $('#multiTextBoxContainer .invtextdiv').each(function () {
        cnt1 = parseFloat($(this).find('input[name="txtdp1"]').val()); cnt2 = parseFloat($(this).find('input[name="txtdp2"]').val());
        if (cnt1 <= cnt2) { clval = cnt1 + ' - ' + cnt2; arrCts.push(clval); $(this).attr('name', clval); }
    })
    console.log(arrCts);
    if (arrCts.length > 0) {
        var strCont = '<div class="invtoggles">';
        $.each(arrCts, function (index, value) {
            if (index == 0)
                strCont = strCont + '<div>' + value + '<a class="deleteCts" popfrom="TextBoxContainer" size="' + value + '" href="javascript:void(0);"><i class="fa fa-close"></i></a></div>';
            else
                strCont = strCont + '<div>' + value + '<a class="deleteCts" popfrom="multiTextBoxContainer" size="' + value + '" href="javascript:void(0);"><i class="fa fa-close"></i></a></div>';
        });
        strCont = strCont + '</div>';

        $('.divCts div, .divCts span').hide(); $('.divCts button').before(strCont);
    }
    else { $('.divCts div, .divCts span').show(); $('.divCts .invtoggles').remove(); }
}

$('.tblCont').on('click', '.deleteCts', function () {
    var len = $(this).parents('.invtoggles').find('div').length - 1;
    var size = $(this).attr('size'); var ulId = $(this).attr('popfrom');
    $('#' + ulId + " .invtextdiv").each(function () { if ($(this).attr('name') == size) { $(this).remove(); } });
    if ($(".invtextdiv").attr('name') == size) { $("#TextBoxContainer :text").val(''); }
    if (len <= 0) { $(this).parents('.tblCont').find('div').show(); $(this).parents('.tblCont').find('span').show(); $(this).parents('.invtoggles').remove(); }
    else { $(this).parents('div:eq(0)').remove(); }
});

$('.tblCont').on('click', '.delete', function () {
    //var masterClass = $(this).parents('.tblCont').attr('class').replace('tblCont ', '');
    var len = $(this).parents('.invtoggles').find('div').length - 1;
    var size = $(this).attr('size'); var ulId = $(this).attr('popfrom');
    $('#' + ulId + ' li').each(function () { if ($(this).hasClass('btn-primary') && $(this).html() == size) { $(this).removeClass('btn-primary'); } });
    $('#' + ulId).parents('.modal-body').find('[id*=amColor] li').removeClass('btn-primary');
    if (len <= 0) { $(this).parents('.tblCont').find('div').show(); $(this).parents('.tblCont').find('span').show(); $(this).parents('.invtoggles').remove(); }
    else { $(this).parents('div:eq(0)').remove(); }
});

/*callback events for modifying*/
function callback(ret) { if (ret.length > 0) { /*console.log(ret); */ retstr = ret.split('@'); resetSearchParams(retstr); } }

function resetSearchParams(resetParams) {
    for (i = 0; i < resetParams.length; i++) {
        contents = resetParams[i].split(':'); var key = contents[0]; vals = contents[1];
        switch (key) {
            case 'Weight': resetInputs("Cts", vals); break; case 'mWeight': resetCtsM(vals); break;
            case 'Shape': resetShapes(vals); break; case 'Col': resetIndexes('Color', vals, 2); break;
            case 'mCol': resetIndexesM('Color', 'btnMCol', vals); break; case 'Clr': resetIndexes('Clarity', vals, 2); break;
            case 'mClr': resetIndexesM('Clarity', 'btnMClr', vals); break; case 'Cut': resetIndexes('Cut', vals, 2); break;
            case 'mCut': resetIndexesM('Cut', 'btnMCut', vals); break; case 'Pol': resetIndexes('Polish', vals, 2); break;
            case 'mPol': resetIndexesM('Polish', 'btnMPol', vals); break; case 'Sym': resetIndexes('Sym', vals, 2); break;
            case 'mSym': resetIndexesM('Sym', 'btnMSym', vals); break; case 'Fl': resetIndexes('Fl', vals, 2); break;
            case 'mFl': resetIndexesM('Fl', 'btnMFl', vals); break; case 'Girdle': resetIndexes('Girdle', vals, 2); break;
            case 'Culet': resetIndexes('Culet', vals, 2); break; case 'Location': resetIndexes('Location', vals, 1); break;
            case 'Lab': resetIndexes('Certificate', vals, 1); break; case 'Rate': resetInputs('Rate', vals); break;
            case 'Rapo': resetInputs('Rapa', vals); break; case 'Table': resetInputs('TablePer', vals); break;
            case 'Depth': resetInputs('DepthPer', vals); break; case 'Length': resetInputs('Length', vals); break;
            case 'Width': resetInputs('Width', vals); break; case 'Height': resetInputs('Height', vals); break;
            case 'Amt': resetInputs('Amt', vals); break; case 'Ratio': resetInputs('Ratio', vals); break;
            case "ShowOnly": resetIndexes('ShowOnly', vals, 1); break; case 'StoneNo': resetSingleInputs('StoneNo', vals); break;
            case 'CertNo': resetSingleInputs('CertNo', vals); break;
        }
    }
}

function resetIndexes(obj, vals, len) {
    var str = vals.split(',');
    if (len > 1) { $('#Frm' + obj + ' option[seq=' + str[0] + ']').attr('selected', 'selected'); $('#To' + obj + ' option[seq=' + str[1] + ']').attr('selected', 'selected'); }
    else { $('#Frm' + obj + ' option[value=' + str[0] + ']').attr('selected', 'selected'); }
}

function resetIndexesM(obj, btnObj, vals) {
    var str = vals.split(','); $lilen = $('#dm' + obj + ' #M' + obj + ' li').length; $strlen = str.length;
    $.each(str, function (i, val) { var divli = "#dm" + obj + " li[seq='" + val + "']"; if ($(divli).attr('seq') == val) { childModelSelector(divli, "dm" + obj, "am" + obj); } });
    $('#' + btnObj).click();
}

function resetShapes(vals) { var strs = vals.split(','); $.each(strs, function (i, item) { $('#shapes #' + item).addClass("nav-li-active"); }); }

function resetInputs(obj, vals) { var strs = vals.split(','); $('#Frm' + obj).val(strs[0]); $('#To' + obj).val(strs[1]); }

function resetSingleInputs(obj, vals) { $('#Frm' + obj).val(vals); }

function resetCtsM(vals) {
    var strs = vals.split('^'); $.each(strs, function (i, item) {
        vals = item.split('-'); if (i == 0) { $('#TextBoxContainer input[name="txt1"]').val(vals[0]); $('#TextBoxContainer input[name="txt2"]').val(vals[1]); }
        else { reAddTextBox(vals); }
    }); $('#btnMCts').click();
};

function reAddTextBox(reVals) {
    var div = document.createElement('DIV');
    div.style.paddingBottom = "17%";
    div.className = 'invtextdiv';
    div.innerHTML = reSetMultiCtsFields();
    document.getElementById("multiTextBoxContainer").appendChild(div);
    $(div).find('input[name="txtdp1"]').val(reVals[0]);
    $(div).find('input[name="txtdp2"]').val(reVals[1]);
}

function reSetMultiCtsFields() {

    return '<div class="col-sm-4 col-xs-4">'
                + '<input name="txtdp1" type="text" style="width: 62px;" class="form-control" onkeypress = "validateDeci(event,this)" />'
            + '</div>'
            + '<div class="col-sm-4 col-xs-4">'
                + '<input name="txtdp2" type="text" style="width: 62px;" class="form-control" onkeypress = "validateDeci(event,this)" onblur="chkPreVal(this,\'txtdp1\')" />'
            + '</div>'
            + '<div class="col-sm-1 col-xs-1">'
                + '<input type="button" value="+" class="btn" onclick="AddTextBox()" />'
            + '</div>'
            + '<div class="col-sm-1 col-xs-1"></div>'
            + '<div class="col-sm-1 col-xs-1">'
                + '<input type="button" value="x" class="btn" onclick="RemoveTextBox(this)" />'
            + '</div>'
}