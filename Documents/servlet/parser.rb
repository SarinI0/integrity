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
    return [ARGV[0],ARGV[1],cert,pkey,payload]
  end
end

