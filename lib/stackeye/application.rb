# frozen_string_literal: true

require 'sinatra/base'

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base

  get '/' do
    # Stackeye::Services::Hardware.set
    # data = Stackeye::Services::Hardware.get

    # TODO: render unsupported if non linux page
    erb(:index, locals: { data: [1,2,3] })
  end

end
