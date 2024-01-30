function swalalert(title,text,icon,obj)
{
    swal({
        title: title,
        text:text,
        icon: icon,
        button: {
            text: "OK",
            value: true
        },
    })
.then((value) => {
    obj.focus();
                    
});
return false;
}
function chgpass()
{
    passicon = $("#passicon i");
    passinput = $("#pass");
    if(passinput.attr("type") == "password")
    {
        passinput.attr("type","text");
        passicon.removeClass("fa-eye");
        passicon.addClass("fa-eye-slash");
    }
    else
    {
        passinput.attr("type","password");
        passicon.removeClass("fa-eye-slash");
        passicon.addClass("fa-eye");
    }
}

$(function () {
  $('[data-ttitle="tooltip"]').tooltip()
})