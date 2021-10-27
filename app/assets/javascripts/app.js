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
    setTimeout(function(){ 
        page1.style.display = "none";
        page2.style.display = "block";
        ; }
        , 1500);
});