
<script>
$(function(){
    $('a').each(function() {
	reff = $(this).attr('href').split('/url?q=')[1];
	$(this).attr('href', 'https://botgoat.com/anja/get?url=' + reff);
    });
   var $label = $('tsf[action=/search]');
   $label.html($label.html().replace("action", "'https://botgoat.com/anja/get?url='"));
   
});
</script>
