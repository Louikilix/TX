// = require app
//= require jquery
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require_tree.

 //Function Home page
 function cercleSelection(){
    function sleep(milliseconds) {
        const date = Date.now();
        let currentDate = null;
        do {
            currentDate = Date.now();
        } while (currentDate - date < milliseconds);
    }
    function getRandomInt(max) {
        return Math.floor(Math.random() * max);
    }

    var slide = document.getElementsByClassName("cercleHome");
    $( "div" ).mousemove(function(event) {
        imageCount = slide.length;
        n = getRandomInt(imageCount)
        for(let i=0;i<imageCount;i++){
            if (i==n){
                slide[i].style.display = 'flex';
            }else{
                slide[i].style.display = 'none';
            }

        }
        sleep(50)
   })
}

function splash(){
$(document).ready(function(){
var splash = document.getElementsByClassName("splash");
setTimeout(() => {
    var steps = 0;
    var timer = setInterval(function() {
    steps++;
    splash[0].style.opacity = 1-(steps/100);
    if(steps > 100) {
        clearInterval(timer);
        splash[0].remove();
    }
}, 10);
   
}, 2000);
})
}

function ecrireBack(){
function randomIntFromInterval(min, max) { // min and max included 
    return Math.floor(Math.random() * (max - min + 1) + min)
}

var intervalId = window.setInterval(function(){

    /// call your function here

    var fullWidth = window.innerWidth;
    var fullHeight = window.innerHeight;
    const font = ["Times New Roman", "Georgia", "Verdana", "Cursive Brush Script MT", "Lucida Handwriting", "Monaco", "Papyrus"];
    const randomFont = Math.floor(Math.random() * font.length);    

    const text = ["11000011100010010110001101110010011010010111001001100101","11000011100010010110001101110010011010010111001001100101","11000011100010010110001101110010011010010111001001100101", "Écrire", "..-.. -.-. .-. .. .-. .", "..-.. -.-. .-. .. .-. .", "..-.. -.-. .-. .. .-. .", "..-.. -.-. .-. .. .-. .","Écrire","Écrire","Écrire","write", "schreiben", "escribir", "scrivere", "írni", "om te skryf ", "napsat", "kirjutama", "schrijven", "escriure", "at skrive", "pisati", "para magsulat", "kirjoittaa", "escrever", "a scrie", "att skriva", "yazmak", "pisać", "ysgrifennu", "ekri", "scríobh", "biex tikteb", "rakstīt", "write", "write", "write", "schreiben", "escribir", "scrivere", "írni","ለመፃፍ", "寫", "Да пишеш", "يكتب", "写", "Mo volavola", "نوشتن", "લખવુ", "Untuk menulis", "ᑎᑎᕋᕐᓂᕐᒧᑦ", "សរសេរ", "書きます", "ಬರೆಯಲು", "לכתוב", "Жазу", "लिखने के लिए", "쓰기에", "نووسین", "Rašyti", "ਲਿਖਣ ਲਈ", "Написать", "Ina ia tusi", "எழுதுவதற்கு", "Писати", "เขียน", "لکھنا", "Để viết"];
    const randomText = Math.floor(Math.random() * text.length);    
    
    const mode = ["vertical-lr","horizontal-tb","horizontal-tb"]
    const randomMode = Math.floor(Math.random() * mode.length);

    var elem = document.createElement("div");
    var s = randomIntFromInterval(5, 50);
    var left = Math.round(Math.random() * fullWidth)
    var top = Math.round(Math.random() * fullHeight)

    elem.textContent = text[randomText];
    elem.style.position = "absolute";
    elem.style.color = "#D3D3D3";
    elem.style.opacity="0";
    elem.style.zIndex=s;
    elem.style.fontSize = s.toString()+"px";
    elem.style.writingMode = mode[randomMode];
    elem.style.fontFamily = font[randomFont];
    elem.style.overflow = "hidden";
    elem.style.left = left + "px";
    elem.style.top = top + "px";
    elem.style.width = (fullWidth - left) + "px";
    elem.style.height = (fullHeight - top) + "px";
    document.body.appendChild(elem);
    var steps = 0;
    var timer = setInterval(function() {
    steps++;
    elem.style.opacity = (s/1000) * steps;
    if(steps >= 20) {
        clearInterval(timer);
        timer = undefined;
    }
}, 50);

}, 700);

}

function sizeImage1 () {
var h = $(window).height();
var w = $(window).width();
var img= document.getElementsByClassName("image");
var text= document.getElementsByClassName("w-d");
 
var imagesLoaded = 0;
// Count the total number of images on the page when the page has loaded.
var totalImages = img.length;

$("img").on("load", function (event) {
  imagesLoaded++;
  if (imagesLoaded == totalImages) {
    allImagesLoaded();
  }
});

function allImagesLoaded() {
  for (i = 0; i < img.length; i++){
    if(img[i].naturalHeight/img[i].naturalWidth >= 1) {
      img[i].style.height = ((w-150)/3).toString()+"px";
      img[i].style.width = (((w-150)/3)*0.8).toString()+"px";
      img[i].style.textAlign = "center";
    }else{
      img[i].style.height = ((w-150)/3)*0.7.toString()+"px";
      img[i].style.width = ((w-150)/3).toString()+"px";
    }
  }
  
  for (i = 0; i < text.length; i++){
  if(img[i].naturalHeight/img[i].naturalWidth >= 1) {
    var id = "im-"+(i).toString()
    var element = document.getElementById(id);
    element.style.justifyContent = "center"
    text[i].style.marginLeft = (((w-150)/3))*parseFloat(text[i].style.marginLeft, 10).toString()+"px";
    text[i].style.marginTop = (((w-150)/3))*parseFloat(text[i].style.marginTop, 10).toString()+"px";
  }else{
    text[i].style.marginLeft = (((w-150)/3))*parseFloat(text[i].style.marginLeft, 10).toString()+"px";
    text[i].style.marginTop = (((w-150)/3)*0.7)*parseFloat(text[i].style.marginTop, 10).toString()+"px"; 
  }
  text[i].style.width= (((w-150)/3))*parseFloat(text[i].style.width, 10).toString()+"px";
  text[i].style.height = (((w-150)/3)*0.7)*parseFloat(text[i].style.height, 10).toString()+"px";
  text[i].style.fontSize = (((w-150)/3)*0.001*parseFloat(text[i].style.fontSize, 10)).toString()+"px";
  text[i].style.lineHeight = "normal";
}
}
}



document.addEventListener("turbolinks:load", function() {
var typePage = document.getElementsByTagName("body")[0].id
console.log(typePage)
if(typePage == "home_home"){
    splash()
    cercleSelection()
    ecrireBack()
}
if(typePage == "home_index"){
    //sizeImage1()
    
}
});
