require 'sinatra/base'

class Stackeye::Application < Sinatra::Base

  get '/' do
    erb(:index, locals: { clients: 'something' })
  end

end
