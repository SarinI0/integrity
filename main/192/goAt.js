
<!--
function proxy() {
        var j = 0;
        var o = 0;
	var a = ['wix', 'ynet'];
        var b = ['cloudflare', 'akamai'];
	var c = ['google','google'];
        var d = [
		'https://10.0.0.11/dogma/get?url=http://',
		'https://10.0.0.11/sonia/get?url=https://',
		'https://10.0.0.11/moon/get?query=',
		'https://10.0.0.11/anja/get?url=https://'
		]
        var j = 0;
        var o = 0;
	var tar = window.location.host + '/' + window.location.pathname;
        for (i = 0; i < a.length; i++){
		if (tar.includes(a[i])){
			var prefix = d[0];
                	j += 1;
                        break;
		} else if (tar.includes(b[i])){
			var prefix = d[1];
                	j += 1;
                        break;
		} else if (tar.includes(c[i])){
                        var prefix = d[2];
                	j += 1;
                        o += 1;		
		}
        } 
        if (j==0) {
		var prefix = d[3];
	}
        if (o==0){
	var lock = prefix+tar;
	window.location = lock;} else {window.location = prefix;}
	window.location = lock;
}
proxy(); 

