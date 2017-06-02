$(function(){

    $(".master-item").click(function(){
        var url = $(this).attr("href").slice(1);
        var options = { resource: $(this).attr("data-resource") };
        $("#detail-1").html($("#loader-template").clone().removeClass("hide"));
        $(".master-item").not(this).removeClass("active");
        $(this).addClass("active");

        $.ajax({
            url: url,
            data: options,
            success: function(response){
                $("#detail-1").html(response);
                $('.datetimepicker').datetimepicker({
                    icons:ICONS
                });

                $(".table-item").click(function(){
                    $("#myModal").modal('show');
                    $("#detail-2").html($("#loader-template").clone().removeClass("hide"));
                    var url = $(this).attr("data-link");

                    $.ajax({
                        url: "main/details",
                        data: { data_url: url },
                        success: function(response){
                            $("#detail-2").html(response);
                        }
                    })


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
