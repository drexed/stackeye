# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'
require 'logger'

class Stackeye::Application < Sinatra::Base
  log_path = File.expand_path('log/stackeye.log')
  request_logger = ::Logger.new(log_path)

  helpers Sinatra::Cookies

  configure do
    use ::Rack::CommonLogger, request_logger
  end

  before do
    env['rack.errors'] =  request_logger
  end

  set :bind, '0.0.0.0'

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
