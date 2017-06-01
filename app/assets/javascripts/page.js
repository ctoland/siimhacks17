$(function(){

    $("#search, #recent-exams").click(function(){
        var url = $(this).attr("href").slice(1);

        $.ajax({
            url: url,
            success: function(response){
                $("#detail-1").html(response);
            }
        });

        return false;
    });
})
