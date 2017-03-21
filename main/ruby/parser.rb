#!/usr/bin/env ruby

require 'optparse'

class Parser
  def par()
    options = {}
    OptionParser.new do |opts|
      opts.on("-h","--host", "enter host") do |h|
        options[:host] = h
      end
      opts.on("-p","--port", "enter port") do |p|
        options[:host] = p
      end
    end.parse!
    ARGV[1] = (ARGV[1])
    cert = OpenSSL::X509::Certificate.new File.read '/home/rt/cert/cert/botgoat_com.crt'
    pkey = OpenSSL::PKey::RSA.new File.read '/home/rt/cert/cert/server.key'
    payload = File.read '/home/rt/botgoat/html/payload.js'
    return [ARGV[0],ARGV[1],cert,pkey,payload]
  end
end

