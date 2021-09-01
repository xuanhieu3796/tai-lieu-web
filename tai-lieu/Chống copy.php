<script>
	$(document).ready(function(){
$('*').bind('cut copy paste contextmenu', function (e) {
e.preventDefault();})});
document.onkeypress = function (event) { 
event = (event || window.event); 
if (event.keyCode == 123) { 
return false; 
} 
} 
document.onmousedown = function (event) { 
event = (event || window.event); 
if (event.keyCode == 123) { 
return false; 
} 
} 
document.onkeydown = function (event) { 
event = (event || window.event); 
if (event.keyCode == 123) { 
return false; 
} };

</script>

<style>
body {
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    -o-user-select: none;
    user-select: none;
}
</style>



Chống copy hình ảnh

<script type="text/javascript">
      function nocontext(e) {
        var clickedTag = (e==null) ? event.srcElement.tagName : e.target.tagName;
        if (clickedTag == "IMG")
          return false;
      }
      document.oncontextmenu = nocontext;
    </script>

<style>
     img {
      -webkit-user-drag: none;
      user-drag: none;
      -webkit-touch-callout: none;
    }
</style>