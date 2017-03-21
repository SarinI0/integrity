<script>
window.onload = function(event) {
    event.stopPropagation(true);
    $('script[src="https://www.google-analytics.com/analytics.js"]').attr('src', '  ');
    $('script[async src="https://www.google-analytics.com/analytics.js"]').attr('async src', '  ');
    $('script[src="https://ssl.google-analytics.com/ga.js"]').attr('src', '  ');
    $('script[src="//connect.facebook.net/en_US/fbevents.js"]').attr('src', '  ');
    $('script[src="//www.googleadservices.com/pagead/conversion_async.js"]').attr('src', '  ');
    $('script[async src="https://ssl.google-analytics.com/ga.js"]').attr('async src', '  ');
    $('script[async src="//connect.facebook.net/en_US/fbevents.js"]').attr('async src', '  ');
    $('script[async src="//www.googleadservices.com/pagead/conversion_async.js"]').attr('async src', '  ');
    event.stopPropagation(false);
};
</script>
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
