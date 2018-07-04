# frozen_string_literal: true

require 'sinatra/base'

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base

  get '/' do
    Stackeye::Services::Hardware.set
    data = Stackeye::Services::Hardware.get
    erb(:index, locals: { data: data })
  end

end
