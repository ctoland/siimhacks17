$(function(){

    $("#search, #recent-exams").click(function(){
        var url = $(this).attr("href").slice(1);
        $("#detail-1").html($("#loader-template").clone().removeClass("hide"));

        $.ajax({
            url: url,
            success: function(response){
                $("#detail-1").html(response);
                $('.datetimepicker').datetimepicker({
                    icons:ICONS
                });
            },
            complete: function(response){
            }

        });

        return false;
    });
})

ICONS={
    time: 'fa fa-time',
    date: 'fa fa-calendar',
    up: 'fa fa-chevron-up',
    down: 'fa fa-chevron-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
}
