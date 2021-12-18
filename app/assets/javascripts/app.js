function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}

// drag&drop module
function initDragElement() {
    var pos1 = 0,
    pos2 = 0,
    pos3 = 0,
    pos4 = 0;
    var wds = document.getElementsByClassName("wd");
    var elmnt = null;
    var currentZIndex = 100; //TODO reset z index when a threshold is passed

    var wd = wds[0];
    var header = getHeader(wd);

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
        var headerItems = element.getElementsByClassName("wd-header");


        if (headerItems.length === 1) {
          return headerItems[0];
        }

        return null;
    }
}

// Resizing module
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


/**********************ajax tip: automatic destroy of dirty productions***************************************/

    //If a user is on the creation process and decide to abort it by quitting the process we set a variable: del (initialized to false) to true 
    //Thus when the page is unload we can launch an ajax request to destroy the curent creation which is considered "dirty"

    var del = false

    // retreive the page where you want to apply the ajax tip: here the creation page:
    var stepToBlock1 = document.getElementById("writing_definitions_show");

    // the protection had also to be added to the  writing_images_create page:
    // Indeed if a user decide to modify the image of a creation on the creation page
    // he or she can encounter a problem in case of image modification: wrong type of file uploaded/ no file uploaded/etc...
    // these problem imply a redirection to the writing_images_create page and explain why we have to aplly the ajax tip here too
    var stepToBlock2 = document.getElementById("writing_images_create");

    if(stepToBlock1 != null || stepToBlock2 != null) {
        $(window).bind('beforeunload', function() {
            del = true
            return(false);
        })
    }

    //here we have to cancel the ajax tip when the user:

    //- click on the link to modify the creation image or the link to publish
    $("a").click(function () {
        del = false
    });
    // these links lead to the creation of javascript pop up handlelinf the ajax tip:
    // see views/writing_images/new.js.erb and views/writing_definitions/edit.js.erb

    //- click on update to update the creation
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
        //def position
        w_x = parseFloat(writing_definition.dataset.x)
        w_y = parseFloat(writing_definition.dataset.y)
        if (( w_x != 0) || (w_y != 0)) {
            x_img = writing_image.offsetLeft
            y_img = writing_image.offsetTop
            img_width = writing_image.offsetWidth
            img_height = writing_image.offsetHeight
            writing_definition.style.left = x_img + w_x*img_width + 'px';
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

/************************************magnifying glass***************************************************/
    
    const pointer1 = document.querySelector('.pointer-1');
    const pointer2 = document.querySelector('.pointer-2');

    const sub_pointer1 = document.querySelector('.sub-pointer-1');
    const sub_pointer2 = document.querySelector('.sub-pointer-2');
    const sub_pointer3 = document.querySelector('.sub-pointer-3');
    const sub_pointer4 = document.querySelector('.sub-pointer-4');
    const sub_pointer5 = document.querySelector('.sub-pointer-5');
    const sub_pointer6 = document.querySelector('.sub-pointer-6');

    if (sub_pointer1 && sub_pointer2 && sub_pointer3 && sub_pointer4 && sub_pointer5 && sub_pointer6) {
        document.getElementById('sub-hidden-part-1').addEventListener('mousemove', (e) => {
            sub_pointer1.style.visibility = "visible"
            sub_pointer1.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-1').addEventListener('mouseout', (e) => {
            sub_pointer1.style.visibility = "hidden"
        });

        document.getElementById('sub-hidden-part-2').addEventListener('mousemove', (e) => {
            sub_pointer2.style.visibility = "visible"
            sub_pointer2.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-2').addEventListener('mouseout', (e) => {
            sub_pointer2.style.visibility = "hidden"
        });

        document.getElementById('sub-hidden-part-3').addEventListener('mousemove', (e) => {
            sub_pointer3.style.visibility = "visible"
            sub_pointer3.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-3').addEventListener('mouseout', (e) => {
            sub_pointer3.style.visibility = "hidden"
        });

        document.getElementById('sub-hidden-part-4').addEventListener('mousemove', (e) => {
            sub_pointer4.style.visibility = "visible"
            sub_pointer4.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-4').addEventListener('mouseout', (e) => {
            sub_pointer4.style.visibility = "hidden"
        });

        document.getElementById('sub-hidden-part-5').addEventListener('mousemove', (e) => {
            sub_pointer5.style.visibility = "visible"
            sub_pointer5.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-5').addEventListener('mouseout', (e) => {
            sub_pointer5.style.visibility = "hidden"
        });

        document.getElementById('sub-hidden-part-6').addEventListener('mousemove', (e) => {
            sub_pointer6.style.visibility = "visible"
            sub_pointer6.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('sub-hidden-part-6').addEventListener('mouseout', (e) => {
            sub_pointer6.style.visibility = "hidden"
        });

        $('.reload-link').click(function() {
            location.reload();
        })
    } else if (pointer1 && pointer2){
        document.getElementById('hidden-part-1').addEventListener('mousemove', (e) => {
            pointer1.style.visibility = "visible"
            pointer1.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('hidden-part-1').addEventListener('mouseout', (e) => {
            pointer1.style.visibility = "hidden"
        });

        document.getElementById('hidden-part-2').addEventListener('mousemove', (e) => {
            pointer2.style.visibility = "visible"
            pointer2.style.clipPath = `circle(100px at ${e.offsetX}px ${e.offsetY}px)`;
        });
        document.getElementById('hidden-part-2').addEventListener('mouseout', (e) => {
            pointer2.style.visibility = "hidden"
        });
        $('.reload-link').click(function() {
            location.reload();
        })
    }

/************************************home page***************************************************/

});


