#!/usr/bin/env ruby

require 'rubygems'
require "webrick"
require 'open-uri'
require 'net/http'
require 'webrick/https' 
require 'securerandom'
require 'sqlite3'
require 'uri'
require 'fileutils'
require "open3"
require 'shellex'
require 'twilio-ruby'
require 'socket'
require 'openssl'

module OpenURI
  class << self
    def redirectable?(uri1, uri2)
      a, b = uri1.scheme.downcase, uri2.scheme.downcase
      a == b || (a == 'http' && b == 'https')
      a == b || (a == 'https' && b == 'http')
    end
  end
end

$pt = File.expand_path('../', __FILE__).to_s
$pt += '/'

inp = ARGV
if inp.length != 5 
  puts "usage: $> sudo ruby  static.rb <txt.filename> <port> <ip> <main==bool> <host=valid url>"
  exit
end

def decrypt(text)
        re = ""
	g = text.slice(0,3)
        k = text.split(g)
        k.each do |build|
            if not build == ""
              re += build.to_i.chr
            end
        end
        return re
end

mou = SecureRandom.hex
$mou = mou
$active = ''
$c = 0
$T = 0
$is = ''
$loged = false

inp = ARGV
$main = false
$host = inp[-1]
if inp[-2] == "true"
  $main = true
end
$ip = inp[-3]
$ashaa = inp[-5]
$port = inp[-4]

FileUtils.cp($pt+'/html/yes.html', $pt+mou+"yes.html")
FileUtils.cp($pt+'/html/no.html', $pt+mou+"no.html")
FileUtils.cp($pt+'/html/verify.html', $pt+mou+"verify.html")
FileUtils.cp($pt+'/html/active.html', $pt+mou+"active.html")
FileUtils.cp($pt+'/html/login.html', $pt+mou+"login.html")
FileUtils.cp($pt+'/html/login2.html', $pt+mou+"login2.html")
f_n = [$pt+mou+"yes.html",
	 $pt+mou+"no.html",$pt+mou+"verify.html", $pt+mou+"active.html"]

f_n.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('8007', $port)
  File.open(file_name, "w") {|file| file.puts new_contents }
end

File.open($pt+$ashaa, 'w') do |file| 
  file.write $mou
end

FileUtils.cp($pt+'/html/signup.html', $pt+mou+"signup.html")
file_names = [$pt+mou+"signup.html"]

file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('href="/login"', 'href="/'+mou+'/login"')
  File.open(file_name, "w") {|file| file.puts new_contents }
end

file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('action="/d/search"', 'action="/'+mou+'/d/search"')
  File.open(file_name, "w") {|file| file.puts new_contents }
end

file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('href="/su"', 'href="/'+mou+'/su"')
  File.open(file_name, "w") {|file| file.puts new_contents }
end

file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('<a href="/">Home</a>', '<a href="/'+mou+'">Home</a>')
  File.open(file_name, "w") {|file| file.puts new_contents }
end


file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub('action="/validate', 'action="/'+mou+'/validate')
  File.open(file_name, "w") {|file| file.puts new_contents }
end

if $main
	$resdef = '<html><head><title></title>
<script> window.location = http://'+$host+":"+$port+'/'+$mou+'/login";</script><head>
<body><script> window.location = http://'+$port+'/'+$mou+'/login";</script></body></html>
	'
else
        $resdef = '<html><head><title></title>
<script> window.location = http://'+$ip+":"+$host+'/'+$mou+'/login";</script><head>
	<body><script> window.location = http://'+$ip+":"+$host+'/'+$mou+'/login";</script>
</body></html>
	'
end

rs = SecureRandom.hex 

host, port, = $ip, $port.to_i
su = File.read $pt+$mou+"signup.html"
lines = File.read($pt+'/html/c').lines

first = su.split('<select name="country">
    <p>&nbsp;</p>')[0]
middle = '<select name="country">
    <p>&nbsp;</p>'
second = su.split('<select name="country">
    <p>&nbsp;</p>')[1]

cont = ''
lines.each do |cn|
        if not cn == ''
	  cont +=  '
		  <option value="' + cn + '">' + cn + '</option>
  '
        end
end

$Sup = first + middle + cont + second

server = WEBrick::HTTPServer.new :Port => $port.to_i,
                                 :Host => $ip,
                                 :Logger => WEBrick::Log.new($pt+'log/'+rs+"r10k_gitlab_webhook.txt",WEBrick::Log::INFO),
                                 :AccessLog => [[File.open($pt+'log/'+rs+"r10k_gitlab_webhook.txt",'w'
                                                                                    ),WEBrick::AccessLog::COMBINED_LOG_FORMAT]]

r10k_comman_log = WEBrick::Log.new($pt+'log/foo.txt',WEBrick::Log::DEBUG)
r10k_comman_log.warn( '..,,..' )
time1 = Time.new
puts " "
puts "Current Time : " + time1.inspect
puts "starting Server,"
if $main
  puts "at host: http://"+$host+':'+$port+"/"+$mou
else
  puts "at host: http://"+$ip+':'+$port+"/"+$mou
end


trap("INT") {
    server.shutdown
}

server.mount_proc '/' + mou + '/su' do |req, res|
    puts req
    res.body = $Sup
end

class Juls < WEBrick::HTTPServlet::AbstractServlet

   def do_GET (req, res)
     args = Array.new
     args.push(req.query["email"])
     args.push(req.query["pass"])
     args.push(req.query["country"])
     args.push(req.query["firstname"])
     args.push(req.query["lastname"])
     args.push(req.query["jobtitle"])
     args.push(req.query["phone"])
     args.push(req.query["Company"])
     args.push(req.query["City"])
     args.push(req.query["Address"])
     args.push(req.query["Zip"])
     args.push(req.remote_ip)
     args.push($mou)
     puts(args)
     redirect = '
<html>
<head>'
     if $main
       redirect +=  '<script> window.location = "http://'+$host+':'+$port+'/'+$mou
     else
       redirect +=  '<script> window.location = "http://'+$ip+':'+$port+'/'+$mou
     end
     redirect += '/accounts";</script>
<head>
<body>
</body>
</html>
'
    sh = 'sudo python '+ $pt +'utils/validation.py ' +$pt+'log/'+$mou
    foo = File.open($pt+"log/" + args[-1], "w")
    args.each do | argu |
       foo.write(argu)
       foo.write("\n")
    end
    foo.close()
    # execv = system(sh)
    Open3.popen2e(sh)
    res.status = 200
    res.content_type = "html"
    res.body = redirect
  end
end

server.mount_proc '/' + $mou + '/accounts' do |req, res|
    res.status = 200
    res.content_type = "html"
    puts req
    bod = File.read $pt+'html/verify.html'
    if $main
      bod = bod.sub('http://127.0.0.1:8007/validation', "http://"+$host+":"+$port+'/'+$mou+'/validation')
    else
      bod = bod.sub('http://127.0.0.1:8007/validation', "http://"+$ip+":"+$port+"/"+$mou+'/validation')
    end
    res.body = bod
end

server.mount_proc '/' + $mou + '/validation' do |req, res|
    res.status = 200
    res.content_type = "html"
    valid = File.read $pt+'log/'+$mou
    puts valid.to_s.include? 'return is valid and why ly ly'
    if valid.to_s.include? 'return is valid and why ly ly'
       rep = '<p style="color:white; font-size: 24px;">an email was sent to activate your account,</p><p style="color:white; font-size: 24px;"> (chack your spam if its not in your inbox)...</p>'
       Open3.popen2e('sudo python ' + $pt+'utils/Send.py ' + $mou +" " + $port.to_s + ' ' +$pt+'log/'+$mou)
    else
       rep = '<p style="color:white; font-size: 24px;">we couldnt verify your identity</p>'
    end
    bod = File.read $pt+$mou+"verify.html"
    bod = bod.sub('our system is verifying your identity', '')
    one = bod.split('<p style="color:white; font-size: 24px;">this may take a while</p> 
<p style="color:white; font-size: 24px;">if your identity is valid you will be redirected,</p>
<p style="color:white; font-size: 24px;">and a varification email will be sent to the email</p>
<p style="color:white; font-size: 24px;">address you supplied for activating your account.</p>')[0]
    sec = bod.split('<p style="color:white; font-size: 24px;">this may take a while</p> 
<p style="color:white; font-size: 24px;">if your identity is valid you will be redirected,</p>
<p style="color:white; font-size: 24px;">and a varification email will be sent to the email</p>
<p style="color:white; font-size: 24px;">address you supplied for activating your account.</p>')[1]
    bod = one + rep + sec
    if $main
       bod = bod.sub('http://127.0.0.1:'+$port+'/validation', 'http://'+$host+':'+$port+'/'+$mou)
    else
       bod = bod.sub('http://127.0.0.1:'+$port+'/validation', 'http://'+$ip+':'+$port+'/'+$mou)
    end
    res.body = bod
end

server.mount_proc '/' + mou + '/activate' do |req, res|
        puts req.path
	if ( req.query["code"] )
         if req.query["code"] == $active
             res.status = 200
	     cmd = 'sudo python '+$pt+'utils/ins.py _krs_ ' + $mou
             system(cmd)
             res.content_type = "html"
             content = File.read $pt+$mou+'yes.html'
             res.body = content
         else
             res.status = 200
             res.content_type = "html"
             content = File.read $pt+$mou+'no.html'
             res.body = content
         end
       else
         content = File.read $pt+$mou+'active.html'
         number = ''
         valid = File.readlines($pt+'log/'+$mou)
         valid.each do |inspect|
            $c += 1
            if (inspect.include? '+') and (12 <= inspect.size) and (2 <= $c)
               number = inspect
               break
            end
         end
         puts $active
         $active = rand(10 ** 5).to_s
         account_sid = 'AC8a746bb57f1332aca6f47efeab26e62d' # your account sid validation.
         auth_token = '2bc35bdeb9b733d81d94caac1eb2c9be' # your auth token for phone validation.
         if (number != '') and ($T == 0)
           $T += 1
           @client = Twilio::REST::Client.new account_sid, auth_token 
      
           @client.account.messages.create(
             from: '+19072684587',
             to: number,
             body: $active
           )
         end
         puts $active
         res.status = 200
         res.content_type = "html"
	 # replace it with a redirection to your accounts section at your site, read the config.sh file.
         res.body = "<html><head></head><body><p>your loged in!!!</p></body></html>" 

       end            
end

server.mount_proc '/' + mou + '/login' do |req, res|

       if (req.query['who'])
             q = decrypt(req.query['who'])
	     p q
             begin
               # anti spam.
               if ( q.split(' ').size == 2 ) or ( q.include? 'php' ) or ( q.include? 'SELECT' ) or ( q.include? '?' ) or ( q.include? '=' )
                    res.body = ' 

<html>
<head>
<title>
</title>
<head>
<style>
k{
  position: absolute;
  top: 25%;
  right: 20%;
  font-size: 36px;
}
</style>
<body>
<k>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;what are you trying to do?<p>
<p>this incedent will be reported you are: '+ip+'<p>
<k>
</body>
</html>


'
                  return
               end
             rescue
             end
             begin
               db = SQLite3::Database.new $pt+"utils/db/SQL/st2.sqlite3"
               stm = db.prepare 'SELECT * FROM ninja WHERE ml="'+q+'";'
               rs = stm.execute
               args = '' 
               rs.each do |row|
                   args = row.join ' '
               end
	       p args
               if ( args.include? q )
                    ml = args.split(' ')[0]
                    $is = ml
                    res.status = 200
                    res.content_type = "html"
                    content = File.read $pt+'/html/login2.html'
                    res.body = content
               else
                  res.status = 200
                  res.content_type = "html"
                  res.body = $resdef
               end
             rescue
                   res.status = 200
                   res.content_type = "html"
                   res.body = $resdef
             ensure
               stm.close if stm
               db.close if db
             end

       elsif (req.query["is"])
          begin
            q = decrypt(req.query["is"])
          rescue
            res.status = 200
            res.content_type = "html"
            res.body = $resdef
          end
          begin
               db = SQLite3::Database.new $pt+"utils/db/SQL/st2.sqlite3"
               stm = db.prepare 'SELECT xyz FROM ninja WHERE ml="'+$is+'";'
               rs = stm.execute
               args = '' 
               rs.each do |row|
                   args = row.join ' '
               end
               if ( args.include? q )
                    $loged = true
                    res.status = 200
                    res.content_type = "html"
                    res.body = '<html><head></head><body><script type="text/javascript">window.location="your site login call back";</script></body></html>'
               else
                 res.status = 200
                 res.content_type = "html"
                 res.body = $resdef
               end
             ensure
               stm.close if stm
               db.close if db
             end
       else     
         content2 = File.read $pt+$mou+'login.html'
         res.status = 200
         res.content_type = "html"
         res.body = content2
       end
end

server.mount "/" + mou + "/validate", Juls

server.mount_proc '/' do |req, res|
    if not ($loged)
     res.status = 200
     res.content_type = "html"
     res.body = '
	<html>
	<head>
	<script>'
    res.body += 'window.location = "http://'+$host+':'+$port+'/'+$mou+'/login'+'";'
    res.body +=	'</script>
	</head>
	<body>
	</body>
	</html>
'
   else 
     res.status = 200
     res.content_type = "html"
     content = '<html><head></head><body><script type="text/javascript">window.location="your site login call back";</script></body></html>'
     res.body = content
   end
end

server.start

begin
ensure
  f_n = [$pt+mou+"yes.html",
	$pt+mou+"no.html", $pt+mou+"verify.html", $pt+mou+"active.html", $pt+mou+"login.html", $pt+mou+"login2.html"
        ]
  f_n.each do |del|
     File.delete(del)
  end
  File.delete($pt+mou+"signup.html")
  File.delete($pt+$ashaa)
end


