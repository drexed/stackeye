# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

  get '/' do
    erb(:index)
  end

  get '/refresh' do
    cookies[:refresh] = refreshing? ? '0' : '1'

    redirect(back)
  end

  get '/unsupported' do
    erb(:unsupported)
  end

end
