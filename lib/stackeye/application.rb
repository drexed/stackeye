# frozen_string_literal: true

%w[base cookies].each do |filename|
  require "sinatra/#{filename}"
end

%w[helpers tools metrics].each do |dirname|
  require_relative "#{dirname}/init"
end

require 'logger'

class Stackeye::Application < Sinatra::Base
  helpers Sinatra::Cookies

  set :bind, '0.0.0.0'

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false

    path = File.expand_path('log/stackeye.log')
    file = File.new(path, 'a+')
    file.sync = true

    use ::Rack::CommonLogger, file
  end

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
