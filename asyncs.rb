require './common'

require 'async_sinatra'
require 'em-http-request'

class App < Sinatra::Base
  enable :logging
  register Sinatra::Async

  aget '/' do
    logger.info "Calling slow api"

    connection = EM::HttpRequest.new(SLOW_API).get
    connection.callback do |response|
      logger.info "Ok, we got stuff"
      contents = connection.response
      body "Body: #{contents}"
    end
  end
  run! if app_file == $0
end


