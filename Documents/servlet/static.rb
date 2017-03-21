#!/usr/bin/env ruby

require 'rubygems'
require "webrick"
require 'open-uri'
require 'net/http'
require 'webrick/https' 
require 'json'
require 'securerandom'

rs = SecureRandom.hex 

host, port, = '..', 80
$content = File.read '..'

module OpenURI
  class << self
    def redirectable?(uri1, uri2)
      a, b = uri1.scheme.downcase, uri2.scheme.downcase
      a == b || (a == 'http' && b == 'https')
      a == b || (a == 'https' && b == 'http')
    end
  end
end

server = WEBrick::HTTPServer.new :Port => port,
                                 :Host => host ,
                                 :DocumentRoot => $content,
                                 :Logger => WEBrick::Log.new('/home/yt/js/log/'+rs+"r10k_gitlab_webhook.log",WEBrick::Log::INFO),
                                 :AccessLog => [[File.open('/home/yt/js/log/'+rs+"r10k_gitlab_webhook.log",'w'
                                                                                    ),WEBrick::AccessLog::COMBINED_LOG_FORMAT]]


r10k_comman_log = WEBrick::Log.new('/home/yt/js/log/foo.log',WEBrick::Log::DEBUG)
r10k_comman_log.warn( '..,,..' )

trap("INT") {
    server.shutdown
}

server.mount_proc '/' do |req, res|
  res.body = $content
end

server.start
