<div id="ytplayer"></div>
<script>
var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/player_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  var player;
  function onYouTubePlayerAPIReady() {
	var cl = window.location.toString();
	var _id = cl.split("&sa")[0].split("watch")[1];
	var id = _id.slice(8,_id.length);
	window.alert(id);
    	window.location = "https://botgoat.com/anja/get?url=https://www.youtube.com/watch?v=" + id;
  }
</script>

