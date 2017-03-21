<php? 
function parse_yturl($url) 
{
    $pattern = '#^(?:https?://)?(?:www\.)?(?:youtu\.be/|youtube\.com(?:/embed/|/v/|/watch\?v=|/watch\?.+&v=))([\w-]{11})(?:.+)?$#x';
    preg_match($pattern, $url, $matches);
    return (isset($matches[1])) ? $matches[1] : false;
}
uri = $_SERVER['REQUEST_URI'];
if ($uri contains 'youtube'){
	$target = explode("https://", uri); 
	parse_yturl($target[2]);
}
?>
