/*------------------------------------------------------------Sign-In*/
addValidateEngine('#signin', "bottomLeft");
$('#btnlogin').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        $(_this).button('loading');
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        var reqUrl = $(this).data('requesturl'); 
        if (!anyerror) {
            $('.notice').attr('style', 'display:inline;'); $('.process').html('Please wait while processing..').fadeIn('slow');
            $.ajax({
                url: reqUrl, type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { if (!d.iserror) { $(_this).button('reset'); window.top.location.href = d.url; } else { $(_this).button('reset'); $('#divMessage').html(d.msg).fadeIn(1500).delay(3000).fadeOut('slow'); return false; } },
                error: function (d) { $(_this).button('reset'); window.location = window.location; invokeMsg('warning', 'Sign In', d.msg); return false; }
            }).complete(function () { $(_this).button('reset'); $('.notice').delay(1000).fadeOut('slow'); });
        }
        return false;
    }
});

/*------------------------------------------------------------Forgot-Pwd*/
addValidateEngine('#fpwd', "topLeft");
$('#btnGetPwd').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        $(_this).button('loading');
        if (!anyerror) {
            $.ajax({
                url: $(this).data('req-url'), type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { $(_this).button('reset'); if (!d.iserror) { SetNotify('success', d.msg); } else { SetNotify('warning', d.msg); } return false; },
                error: function (d) { $(_this).button('reset'); SetNotify('warning', d.msg); window.location = window.location; return false; }
            }).complete(function () { $(_this).button('reset'); });
        }
        return false;
    }
});

/*------------------------------------------------------------Reset-Pwd*/
addValidateEngine('#resetpwd', "bottomLeft");
$('#btnResetPwd').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        $(_this).button('loading');
        if (!anyerror) {
            $.ajax({
                url: $(this).data('req-url'), type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { $(_this).button('reset'); if (!d.isError) { $(_form).get(0).reset(); SetNotify('success', d.msg); } else { SetNotify('warning', d.msg); } return false; },
                error: function (d) { $(_this).button('reset'); SetNotify('warning', d.msg); window.location = window.location; return false; }
            }).complete(function () { $(_this).button('reset'); });
        }
        return false;
    }
});

/*------------------------------------------------------------Sign-Up*/

addValidateEngine('#frmSignUp', "bottomLeft");
$('#btnSignUp').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        $(_this).button('loading');
        if (!anyerror) {
            $.ajax({
                url: $(this).data('req-url'), type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { $(_this).button('reset'); if (!d.iserror) { SetNotify('success', d.msg); } else { SetNotify('warning', d.msg); } return false; },
                error: function (d) { $(_this).button('reset'); window.location = window.location; SetNotify('warning', d.msg); return false; }
            }).complete(function () { $(_this).button('reset'); });
        }
        return false;
    }
});

/*------------------------------------------------------------ClientProfile*/

addValidateEngine('#frmProfile', "bottomLeft");
$('#btnProfile').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        $(_this).button('loading'); SetLoadingProc();
        if (!anyerror) {
            $.ajax({
                url: $(this).data('req-url'), type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { $(_this).button('reset'); RemoveLoadingProc(); if (!d.iserror) { SetNotify('success', d.msg); } else { SetNotify('warning', d.msg); } return false; },
                error: function (d) { $(_this).button('reset'); RemoveLoadingProc(); window.location = window.location; SetNotify('warning', d.msg); }
            }).complete(function () { $(_this).button('reset'); RemoveLoadingProc(); });
        }
        return false;
    }
});
/*------------------------------------------------------------ClientPrimaryProfile*/
addValidateEngine('#frmPrimeProfile', "bottomLeft");
$('#btnPrimaryProfile').on('click', function (e) {
    e.preventDefault();
    var _this = $(this);
    var _form = $(this).closest('form');
    if ($(_form).validationEngine('validate')) {
        var validator = $(_form).validate(); var anyerror = false;
        _form.find('input').each(function () { if (!validator.element(this)) { anyerror = true; } });
        $(_this).button('loading'); SetLoadingProc();
        if (!anyerror) {
            $.ajax({
                url: $(this).data('req-url'), type: 'POST', data: _form.serialize(), datatype: 'json',
                success: function (d) { $(_this).button('reset'); RemoveLoadingProc(); if (!d.iserror) { SetNotify('success', d.msg); } else { SetNotify('warning', d.msg); } return false; },
                error: function (d) { $(_this).button('reset'); RemoveLoadingProc(); window.location = window.location; SetNotify('warning', d.msg); return false; }
            }).complete(function () { $(_this).button('reset'); RemoveLoadingProc(); });
        }
        return false;
    }
});

/*------------------------------------------------------------Sign-Up*/
function addValidateEngine(_form, _promptPosition) {
    $(_form).validationEngine({ ajaxFormValidation: true, promptPosition: _promptPosition, scroll: true, maxErrorsPerField: 1 });
}