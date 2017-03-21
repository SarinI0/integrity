#!/usr/bin/env ruby

require 'rubygems'
require 'webrick'
require 'open-uri'
require 'net/http'
require 'webrick/https' 
require 'openssl'
require 'json' 
require_relative("parser")

ArgPar = Parser.new

host, port, _cert_, _key_ = ArgPar.par()[0], ArgPar.par()[1], ArgPar.par()[2], ArgPar.par()[3] 
$host = host 
$port = port

module OpenURI
  class << self
    def redirectable?(uri1, uri2)
      a, b = uri1.scheme.downcase, uri2.scheme.downcase
      a == b || (a == 'http' && b == 'https')
      a == b || (a == 'https' && b == 'http')
    end
  end
end

class DigestContent < WEBrick::HTTPServlet::AbstractServlet
    
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
            sub = "s://"+"botgoat.com/sonia/"+"/get?url=http://"
            renderedContent += self.buildLine(newc, sub)
          else
            sub = "://"+"botgoat.com/sonia/"+"/get?url=https://"
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
          url = request.query["url"]
          if (not ((url.split(":")[0] == "http") or (url.split(":")[0] == "https")))
            return nil
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
       else
         #TODO: another method ...
       end
    end
end

cert = _cert_
pkey = _key_

server = WEBrick::HTTPServer.new(
	:host => $host,
	:Port => $port,
        :SSLEnable => true,
	:SSLCertificate => cert,
	:SSLPrivateKey => pkey
	)

server.mount "/sonia/", DigestContent

trap("INT") {
    server.shutdown
}

server.start

