# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'

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

  def base_path
    return unless ENV['RAILS_ENV']
    '/stackeye'
  end

end
