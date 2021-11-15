function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}

function initDragElement() {
    var pos1 = 0,
    pos2 = 0,
    pos3 = 0,
    pos4 = 0;
    var wds = document.getElementsByClassName("wd");
    var elmnt = null;
    var currentZIndex = 100; //TODO reset z index when a threshold is passed

    var wd = wds[0];
    var header = getHeader(wds);

    wd.onmousedown = function() {
      this.style.zIndex = "" + ++currentZIndex;
    };

    if (header) {
      header.parentWd = wd;
      header.onmousedown = dragMouseDown;
    }

    function dragMouseDown(e) {
        elmnt = this.parentWd;
        elmnt.style.zIndex = "" + ++currentZIndex;

        e = e || window.event;
        // get the mouse cursor position at startup:
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        // call a function whenever the cursor moves:
        document.onmousemove = elementDrag;
    }

    function elementDrag(e) {
        if (!elmnt) {
          return;
        }

        e = e || window.event;
        // calculate the new cursor position:
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        // set the element's new position:
        elmnt.style.top = elmnt.offsetTop - pos2 + "px";
        elmnt.style.left = elmnt.offsetLeft - pos1 + "px";
    }

    function get_coordinates() {
        img = document.getElementById("writing-image-ele")
        x_img = img.offsetLeft
        y_img = img.offsetTop
        img_width = img.offsetWidth
        img_height = img.offsetHeight
        param_y = (parseFloat(elmnt.style.top) - y_img)/img_height
        param_x = (parseFloat(elmnt.style.left) - x_img)/img_width
        document.getElementById('x').value = param_x
        document.getElementById('y').value = param_y
    }

    function closeDragElement() {
        /* stop moving when mouse button is released:*/
        get_coordinates()
        document.onmouseup = null;
        document.onmousemove = null;
    }

    function getHeader(element) {
        var headerItems = element;

        if (headerItems.length === 1) {
          return headerItems[0];
        }

        return null;
    }
}

function initResizeElement() {
    var wds = document.getElementsByClassName("wd");
    var element = null;
    var startX, startY, startWidth, startHeight;

    var wd = wds[0];

    var right = document.createElement("div");
    right.className = "resizer-right";
    wd.appendChild(right);
    right.addEventListener("mousedown", initDrag, false);
    right.parentWd = wd;

    var bottom = document.createElement("div");
    bottom.className = "resizer-bottom";
    wd.appendChild(bottom);
    bottom.addEventListener("mousedown", initDrag, false);
    bottom.parentWd = wd;

    var both = document.createElement("div");
    both.className = "resizer-both";
    wd.appendChild(both);
    both.addEventListener("mousedown", initDrag, false);
    both.parentWd = wd;

    function initDrag(e) {
        element = this.parentWd;
        startX = e.clientX;
        startY = e.clientY;
        startWidth = parseFloat(document.defaultView.getComputedStyle(element).width);
        startHeight = parseFloat(document.defaultView.getComputedStyle(element).height);
        document.documentElement.addEventListener("mousemove", doDrag, false);
        document.documentElement.addEventListener("mouseup", stopDrag, false);
    }

    function doDrag(e) {
        element.style.width = startWidth + e.clientX - startX + "px";
        element.style.height = startHeight + e.clientY - startY + "px";
    }

    function get_size() {
        img = document.getElementById("writing-image-ele")
        img_width = img.offsetWidth
        img_height = img.offsetHeight
        param_h = parseFloat(element.style.height)/img_height
        param_w = parseFloat(element.style.width)/img_width
        document.getElementById('w').value = param_w
        document.getElementById('h').value = param_h
    }

    function stopDrag() {
        get_size();
        document.documentElement.removeEventListener("mousemove", doDrag, false);
        document.documentElement.removeEventListener("mouseup", stopDrag, false);
    }
}


docReady(function() {
    // DOM is loaded and ready for manipulation here

/**********************display log***************************************/

    var page1 = document.getElementById("page1");
    var page2 = document.getElementById("page2");
    if (page1 && page2) {
        setTimeout(function(){ 
            page1.style.display = "none";
            page2.style.display = "block";
        }
        , 1500);
    }


/**********************automatic destroy of dirty productions***************************************/

    var del = false

    var stepToBlock = document.getElementById("writing_definitions_show");
    if(stepToBlock != null) {
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

/************************************DRAGGING***************************************************/

    var writing_definition = document.getElementById('draggable-element')
    var writing_image = document.getElementById("writing-image-ele")
    if (writing_definition && writing_image) {
        writing_definition.style.fontSize = 0.01 * (writing_image.offsetWidth + writing_image.offsetHeight)+ 'px'
        //def position
        w_x = parseFloat(writing_definition.dataset.x)
        w_y = parseFloat(writing_definition.dataset.y)
        if (( w_x != 0) || (w_y != 0)) {
            x_img = writing_image.offsetLeft
            y_img = writing_image.offsetTop
            img_width = writing_image.offsetWidth
            img_height = writing_image.offsetHeight
            writing_definition.style.left = x_img + w_x*img_width + 20 + 'px';
            writing_definition.style.top = y_img + w_y*img_height + 'px';
        }

        //def size
        w_w = parseFloat(writing_definition.dataset.w)
        w_h = parseFloat(writing_definition.dataset.h)
        if (( w_w != 0) || (w_h != 0)) {
            img_width = writing_image.offsetWidth
            img_height = writing_image.offsetHeight
            writing_definition.style.width = w_w*img_width + 'px';
            writing_definition.style.height = w_h*img_height + 'px';
        }

        initDragElement();
        initResizeElement();
    }

 
});

