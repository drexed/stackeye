# frozen_string_literal: true

require 'sinatra/base'


Stackeye::Services::Hardware.set

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base

  get '/' do
    erb(:index, locals: { clients: 'something' })
  end

end
