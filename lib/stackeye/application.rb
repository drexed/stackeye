# frozen_string_literal: true

require 'sinatra/base'

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Metrics::Server.set
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base
  # TODO: render unsupported if non linux page

  get '/' do
    erb(:index, locals: { data: [1,2,3] })
  end

  get '/server' do
    # 300.times do
    #   Stackeye::Metrics::Server.set
    # end
    @metrics = Stackeye::Metrics::Server.new
    erb(:"metrics/server/index")
  end

end
