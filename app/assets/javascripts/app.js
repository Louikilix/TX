function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}    
docReady(function() {
    
    // DOM is loaded and ready for manipulation here
    var page1 = document.getElementById("page1");
    var page2 = document.getElementById("page2");
    if (page1 && page2) {
        setTimeout(function(){ 
            page1.style.display = "none";
            page2.style.display = "block";
        }
        , 1500);
    }

    var del = false

    var stepToBlock = document.getElementById("writing_definitions_show");
    if(stepToBlock != null) {
        $("#fake-button").click();
        $(window).bind('beforeunload', function() {
            //following two lines will cause the browser to ask the user if they
            //want to leave. The text of this dialog is controlled by the browser.
            //e.preventDefault(); //per the standard
            //e.returnValue = ''; //required for Chrome
            // user has left the page, do stuff here
            del = true
            return(false);
        })
    }

    $("a").click(function () {
        del = false
    });

    $('form').submit(function () {
        del = false
        $(window).unbind('beforeunload');
    });

    $(window).on('unload', function (){
        if (del) {
            var id = $("#hidden-form").data("id") 
            $.ajax({
              type: "DELETE",
              url: "/writing_definitions/"+id
            });
        }
    })

    function ConfirmLeaveMessage() {
        //return undefined;
        return "Are you sure you want to leave this page without saving?";
    }

});