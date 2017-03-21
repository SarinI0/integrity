<script>
$(function(){
    var cl = window.location.toString();
    if (cl.includes("&spfreload=10")) { 
	window.location = 'https://botgoat.com/anja/get?url=https://www.youtube.com/watch?v=' + cl.split("watch?v=")[1].split("&spfreload=1")[0]; } 
});
</script>
<script>
$(function(){
    var cl = window.location.toString();
    $('a').each(function() {
	 $(this).attr('href', 'https://botgoat.com/anja/get?url=https://www.youtube.com/watch?v=' + this.href.split("watch?v=")[1]);
      });  
});
</script>
