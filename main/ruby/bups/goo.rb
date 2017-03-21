#!/usr/bin/env ruby

require 'webrick'
require 'webrick/https' 
require 'openssl'
include WEBrick

require_relative("parser") 

ArgPar = Parser.new

host, port, _cert_, _key_ = ArgPar.par()[0], ArgPar.par()[1], ArgPar.par()[2], ArgPar.par()[3] 
$path = "/home/rt/botgoat/html/googleHack.html"
$host = host 
$port = port
$cert = _cert_
$key = _key_ 
 
def start_webrick(config = {})
  config.update(:host => $host+'/juls/', :Port =>$port,
  :SSLEnable => true, :SSLCertificate => $cert,
  :SSLPrivateKey => $key
  )     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end
 
start_webrick(:DocumentRoot => $path)
