$(document).ready(function () {
    $("div.bhoechie-tab-menu>div.list-group>a").click(function (e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});

/*$('#file-fr1').fileinput({ language: 'fr', uploadUrl: '#', allowedFileExtensions: ['jpg', 'png', 'gif'], });
$("#file-0").fileinput({ 'allowedFileExtensions': ['jpg', 'png', 'gif'], });*/


/* xlsx file uplaoder script */
