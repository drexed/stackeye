# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

  get '/' do
    metric = Stackeye.configuration.metrics.first

    redirect("#{base_path}/#{metric}")
  end

  get '/refresh' do
    cookies[:refresh] = refreshing? ? '0' : '1'

    redirect(back)
  end

  get '/unsupported' do
    erb(:unsupported)
  end

end
