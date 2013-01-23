# Em-synchrony powered app
# it's still makeing use of Event machine and asynchronous code
# but by use of fibers it makes the code look synchronous
require './common'

require 'em-synchrony'
require 'em-http-request'
require 'em-synchrony/em-http'
require 'rack/fiber_pool'

class App < Sinatra::Base
  enable :logging
  use Rack::FiberPool, size: 10
  disable :threaded # stuff can blow up if this is enabled

  get '/' do
    logger.info "EM Synchrony Calling slow api"

    connection = EM::HttpRequest.new(SLOW_API).get
    contents = connection.response
    logger.info "EM Synchrony We got body"
    body "EM Synchrony Body: #{contents}\n"
  end

end
