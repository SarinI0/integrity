<script>
$(function(){
    $('tr').each(function() {
	a = toString($(this).find('kv')).split("<b>")[0];
	b = toString($(this).find('kv')).split("</b>")[1];
	re = a +'youtube' + b;
	window.alert(re); 
	$(this).attr('href', 'https://botgoat.com/anja/get?url=' + re);
    });
   var $label = $('tsf[action=/search]');
   $label.html($label.html().replace("action", "'https://botgoat.com/anja/get?url='"));
   
});
</script>
