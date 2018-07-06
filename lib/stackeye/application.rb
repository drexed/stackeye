# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'

# Stackeye::Tools::Schedule.cron('*/5 * * * *') do
#   Stackeye::Metrics::Server.set
# end
#
# Stackeye::Tools::Schedule.cron('0 0 * * *') do
#   Stackeye::Tools::Database.truncate
# end

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
    Stackeye::Metrics::Server.set

    @title = 'Server'
    @metrics = Stackeye::Metrics::Server.new
    erb(:"metrics/server/index")
  end

end
