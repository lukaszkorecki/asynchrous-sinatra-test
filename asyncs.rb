# This is Async-Sinatra powered app
# it uses EventMachine Deferrable as response object
# and then uses that as a response by invoking ether callback or errback
require './common'

require 'async_sinatra'
require 'em-http-request'

class App < Sinatra::Base
  enable :logging
  register Sinatra::Async

  aget '/' do
    logger.info "Async Calling slow api"

    connection = EM::HttpRequest.new(SLOW_API).get
    connection.callback do |response|
      contents = connection.response
      logger.info "Async We got body"
      body "Async Body: #{contents}\n"
    end
  end
end
