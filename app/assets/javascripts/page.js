$(function(){

    $("#search, #recent-exams").click(function(){
        var url = $(this).attr("href").slice(1);

        $("#loader").removeClass("hide");
        $.ajax({
            url: url,
            success: function(response){
                $("#detail-1").html(response);
                $('.datetimepicker').datetimepicker({
                    icons:ICONS
                });
                $("#loader").addClass("hide");
            },
            complete: function(response){
                $("#loader").addClass("hide");
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
