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
                            initCornerstone();
                        }
                    })


                });

                $(".launch-images").click(function(){
                    var acc = $(this).attr("data-acc");
                    var mrn = $(this).attr("data-mrn");
                    var url = "http://www.google.com?acc=" + acc + "&mrn=" + mrn;
                    window.open(url);
                    return false;
                });
            },
            complete: function(response){
            }

        });

        return false;
    });

})

cornerstoneWADOImageLoader.configure({
    beforeSend: function(xhr) {
        // Add custom headers here (e.g. auth tokens)
        var apiKey = $('#apikey').val();
        if(apiKey && apiKey.length) {
            xhr.setRequestHeader('APIKEY', apiKey);
        }
    }
});


var loaded = false;

function loadAndViewImage(imageId) {
    var element = $('#dicomImage').get(0);
    //try {
    cornerstone.loadImage(imageId).then(function(image) {
        console.log(image);
        var viewport = cornerstone.getDefaultViewportForImage(element, image);
        cornerstone.displayImage(element, image, viewport);
        if(loaded === false) {
            cornerstoneTools.mouseInput.enable(element);
            cornerstoneTools.mouseWheelInput.enable(element);
            cornerstoneTools.wwwc.activate(element, 1); // ww/wc is the default tool for left mouse button
            cornerstoneTools.pan.activate(element, 2); // pan is the default tool for middle mouse button
            cornerstoneTools.zoom.activate(element, 4); // zoom is the default tool for right mouse button
            cornerstoneTools.zoomWheel.activate(element); // zoom is the default tool for middle mouse wheel
            loaded = true;
        }
    }, function(err) {
        alert(err);
    });
    /*}
     catch(err) {
     alert(err);
     }*/
}

function getImageFrameURI(metadataURI, metadata) {
    // Use the BulkDataURI if present int the metadata
    if(metadata["7FE00010"] && metadata["7FE00010"].BulkDataURI) {
        return metadata["7FE00010"].BulkDataURI
    }

    // fall back to using frame #1
    return metadataURI + '/frames/1';
}


function downloadAndView(url){
    var metadataURI = url + "/metadata";
    $.ajax({
        url: metadataURI,
        headers: {
            accept: 'application/json'
        }
    }).done(function(data) {
        // Make sure it's a JSON document
        data = JSON.parse(data);

        console.log(data);

        var metadata = data[0];

        var imageFrameURI = getImageFrameURI(metadataURI, metadata);
        var imageId = 'wadors:' + imageFrameURI;

        cornerstoneWADOImageLoader.wadors.metaDataManager.add(imageId, metadata);

        // image enable the dicomImage element and activate a few tools
        loadAndViewImage(imageId);
    });
}

$(cornerstone).bind('CornerstoneImageLoadProgress', function(event, eventData) {
    $('#loadProgress').text('Image Load Progress: ' + eventData.percentComplete + "%");
});


function initCornerstone(){
    var element = $('#dicomImage').get(0);
    if ( element ){
        cornerstone.enable(element);
    }
    $(".load-url").click(function(){
        downloadAndView($(this).html());
    });
}

$(document).ready(function() {


    //$('.load-test').click(function(e) {
        //debugger
    //});

    $('#selectFile').on('change', function(e) {
        // Add the file to the cornerstoneFileImageLoader and get unique
        // number for that file
        var file = e.target.files[0];
        var imageId = cornerstoneWADOImageLoader.fileManager.add(file);
        loadAndViewImage(imageId);
    });
});


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
