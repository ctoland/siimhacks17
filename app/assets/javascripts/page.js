$(function(){

    $("#search, #recent-exams").click(function(){
        var url = $(this).attr("href").slice(1);

        $("#loader").removeClass("hide");
        $.ajax({
            url: url,
            success: function(response){
                $("#detail-1").html(response);
                $("#loader").addClass("hide");
            },
            complete: function(response){
                $("#loader").addClass("hide");
            }

        });

        return false;
    });
})
