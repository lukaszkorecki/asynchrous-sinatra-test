require './common'

require 'em-synchrony'
require 'em-http-request'
require 'em-synchrony/em-http'
require 'rack/fiber_pool'

class App < Sinatra::Base
  enable :logging
  use Rack::FiberPool, size: 10
  disable :threaded

  get '/' do
    logger.info "Calling slow api"

    connection = EM::HttpRequest.new(SLOW_API).get
    contents = connection.response
    body "Body: #{contents}"
  end

  run! if app_file == $0
end



