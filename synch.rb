# regular synchrnous, blocking code
require './common'

class App < Sinatra::Base
  enable :logging

  get '/' do
    logger.info "Synchronous Calling slow api"
    contents = ::Net::HTTP.get_response(URI(SLOW_API)).body
    logger.info "Synchronous We got body"
    body "Synchronous Body: #{contents}\n"
  end
end

