$(function () {
    if (window.location.search != '') return; $.ajax({
        contentType: 'application/json; charset=utf-8', datatype: 'json', type: "POST",
        success: function (data) { $('.stDetails').html(formatTable(data.aaData[0])); activateImages(data.refLinks); createImgevents(); },
        error: function () { alert('error'); }
    });
});

function createImgevents() {
    $("div.bhoechie-tab-menu>div.list-group>a.list-group-item").on('click', function (e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active"); $(this).addClass("active"); var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active"); $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
}

function printContent(el) {
    var restorepage = document.body.innerHTML; printcontent = document.getElementById(el).innerHTML;
    document.body.innerHTML = printcontent; window.print(); document.body.innerHTML = restorepage;
}

function formatTable(data) {
    str = '';
    str += '<div class="col-md-3"><span class="control-label">Stone ID </span> : <span class="seprate">' + data[6] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Certificate</span> : <span class="seprate"> ' + data[3] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Country</span> : <span class="seprate"> ' + data[1] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Report No</span> : <span class="seprate"> ' + data[4] + '</span></div>';

    str += '<div class="col-md-3"><span class="control-label">Shape </span> : <span class="seprate"> ' + data[7] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Carat </span> : <span class="seprate"> ' + data[8] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Color </span> : <span class="seprate"> ' + data[9] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Clarity </span> : <span class="seprate"> ' + data[10] + '</span></div>';

    str += '<div class="col-md-3"><span class="control-label">Cut </span> : <span class="seprate">' + data[11] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Polish </span> : <span class="seprate"> ' + data[12] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Symmetry </span> : <span class="seprate"> ' + data[13] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Fluorescence </span> : <span class="seprate"> ' + data[30] + '</span></div>';

    str += '<div class="col-md-3"><span class="control-label">Discount </span> : <span class="seprate"> ' + data[16] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">$/Carat </span> : <span class="seprate"> ' + data[15] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Table </span> : <span class="seprate"> ' + data[20] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Culet </span> : <span class="seprate"> ' + data[41] + '</span></div>';

    str += '<div class="col-md-3"><span class="control-label">Girdle </span> : <span class="seprate"> ' + data[22] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Girdle % </span> : <span class="seprate"> ' + data[26] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">CR Angle </span> : <span class="seprate"> ' + data[32] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">CR Height </span> : <span class="seprate"> ' + data[33] + '</span></div>';

    str += '<div class="col-md-3"><span class="control-label">Shade </span> : <span class="seprate"> ' + data[49] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Fluor Color </span> : <span class="seprate"> ' + data[40] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Pav Angle </span> : <span class="seprate"> ' + data[35] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Pav Height </span> : <span class="seprate"> ' + data[36] + '</span></div>';

    //str += '<div class="col-md-3"><span class="control-label">Treatment </span> : <span class="seprate"> </span></div>';

    str += '<div class="col-md-3"><span class="control-label">Color Descr. </span> : <span class="seprate"> ' + data[42] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Measurement</span> : <span class="seprate"> ' + data[21] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Diameter </span> : <span class="seprate"> ' + data[25] + '</span></div>';
    str += '<div class="col-md-3"><span class="control-label">Depth </span> : <span class="seprate"> ' + data[19] + '</span></div>';

    return str;
}

function activateImages(data) {
    var imgstr = '', imgActstr = '', imgCert = '', imgVrCert = '', videoUrl = '', cnt = 0;
    if (data.digital != undefined) {
        cnt++;
        imgstr += '<a href="#" class="list-group-item text-center active"><img title="Digital" class="img-responsive center-block temimg" src="' + data.digital + '" /></a>';
        imgActstr += '<div class="bhoechie-tab-content active"><center><img class="img-responsive center-block tabimg" src="' + data.digital + '" /></center></div>';
    }
    if (data.Arrow != undefined) {
        cnt++;
        imgstr += '<a href="#" class="list-group-item text-center"><img title="Arrow" class="img-responsive center-block temimg" src="' + data.Arrow + '" /></a>';
        imgActstr += '<div class="bhoechie-tab-content "><center><img class="img-responsive center-block tabimg" src="' + data.Arrow + '" /></center></div>';
    }
    if (data.Asset != undefined) {
        cnt++;
        imgstr += '<a href="#" class="list-group-item text-center"><img title="Asset" class="img-responsive center-block temimg" src="' + data.Asset + '" /></a>';
        imgActstr += '<div class="bhoechie-tab-content"><center><img class="img-responsive center-block tabimg" src="' + data.Asset + '" /></center></div>';
    }
    if (data.Heart != undefined) {
        cnt++;
        imgstr += '<a href="#" class="list-group-item text-center"><img title="Heart" class="img-responsive center-block temimg" src="' + data.Heart + '" /></a>';
        imgActstr += '<div class="bhoechie-tab-content"><center><img class="img-responsive center-block tabimg" src="' + data.Heart + '" /></center></div>';
    }
    if (data.Ideal != undefined) {
        cnt++;
        imgstr += '<a href="#" class="list-group-item text-center"><img title="Ideal" class="img-responsive center-block temimg" src="' + data.Ideal + '" /></a>';
        imgActstr += '<div class="bhoechie-tab-content"><center><img class="img-responsive center-block tabimg" src="' + data.Ideal + '" /></center></div>';
    }

    if (data.Cert != undefined) {
        imgCert += '<img src="' + data.Cert + '" width="100%" />';
        imgVrCert += '<a href="' + data.verifyCert + '" target="_blank" style="float: right; background: #a3965f; color: white; font-weight: 800;"><i class="fa fa-check-circle" aria-hidden="true" style="padding: 0px 4px;"></i>Verify Certificate</a>'
    }
    else { imgCert += '<img class="img-responsive center-block tabimg" src="../../content/images/no-image.png" />'; }

    if (data.Video != undefined) { videoUrl += '<video class="video" style="width: 100%; height: 250px;" controls> <source src="' + data.Video + '" type="video/mp4" />Your browser does not support the video tag.</video>'; }
    else { videoUrl += '<img class="img-responsive center-block tabimg" src="../../content/images/no-video.gif" />'; }

    $('.list-group').html(imgstr);
    if (cnt == 0) { imgActstr += '<div class="bhoechie-tab-content active"><center><img class="img-responsive center-block tabimg" src="../../content/images/no-image.png" /></center></div>'; }
    $('.bhoechie-tab').html(imgActstr);
    $('#certi').html(imgCert);
    $('.h4Cert>span').html(imgVrCert);
    $('.diavideo').html(videoUrl);
}

$('.stoneDetImg').on('click', function (e) { download(this, 'img'); });
$('.stoneDetCert').on('click', function (e) { download(this, 'certi'); });
$('.stoneDetVideo').on('click', function (e) { download(this, 'video'); });
$('.stoneDetAll').on('click', function (e) { download(this, 'All'); });

function download(obj, filetype) {
    $.ajax({
        url: $(obj).data('req-url'), type: 'POST', datatype: 'json',
        data: '{"req":"' + location.pathname.substring(location.pathname.lastIndexOf('/') + 1) + '" ,"filetype":"' + filetype + '"}',
        contentType: 'application/json; charset=utf-8', success: function (data) { window.open(data.respUrl + "?refCd=" + data.refCd + "&filename=" + data.FileName, '_blank'); },
        error: function () { alert('Something went wrong..'); }
    });
}