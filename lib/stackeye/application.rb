# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'

Stackeye::Schedule.cron('*/5 * * * *') do
  Stackeye::Metrics::Server.set
  Stackeye::Tools::Database.truncate
end

class Stackeye::Application < Sinatra::Base
  helpers Sinatra::Cookies

  # TODO: render unsupported if non linux page

  get '/' do
    erb(:index)
  end

  get '/refresh' do
    if cookies.key?(:refresh)
      cookies.delete(:refresh)
    else
      cookies[:refresh] = true
    end

    redirect back
  end

  get '/server' do
    @title = 'Server'
    @metrics = Stackeye::Metrics::Server.new
    erb(:"metrics/server/index")
  end

end
