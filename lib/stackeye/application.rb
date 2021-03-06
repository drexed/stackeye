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

  set :app_file, __FILE__
  set :bind, '0.0.0.0'

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    dir = File.expand_path('log')
    Dir.mkdir(dir) unless File.directory?(dir)
    file = File.new("#{dir}/stackeye.log", 'a+')
    file.sync = true

    use ::Rack::CommonLogger, file
  end

end
