# frozen_string_literal: true

require 'sinatra/base'


# Stackeye::Services::Hardware.set

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base

  get '/' do
    data = Stackeye::Services::Hardware.get
    erb(:index, locals: { data: data })
  end

end
