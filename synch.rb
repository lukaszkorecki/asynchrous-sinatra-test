require './common'

class App < Sinatra::Base
  enable :logging

  get '/' do
    logger.info "Calling slow api"
    contents = ::Net::HTTP.get_response(URI(SLOW_API)).body
    body "Body: #{contents}"
  end
end

