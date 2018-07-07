# frozen_string_literal: true

%w[base cookies].each do |filename|
  require "sinatra/#{filename}"
end

%w[tools metrics helpers routes].each do |dirname|
  require_relative "#{dirname}/init"
end

require 'logger'

class Stackeye::Application < Sinatra::Base
  helpers Sinatra::Cookies

  set :bind, '0.0.0.0'

  configure :development do
    set :app_file, __FILE__

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

end
