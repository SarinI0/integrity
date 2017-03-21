require 'webrick'
require 'webrick/https' 
require 'openssl'
include WEBrick
 
def start_webrick(config = {})
  config.update(:host => '46.121.206.221', :Port =>80
  )     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end
 
start_webrick(:DocumentRoot => '/home/rt/botgoat/html/redirect.html')
