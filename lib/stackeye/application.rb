# frozen_string_literal: true

require 'sinatra/base'

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Tools::Database.truncate
# end

class Stackeye::Application < Sinatra::Base
  # TODO: render unsupported if non linux page

  get '/' do
    erb(:index, locals: { data: [1,2,3] })
  end

  get '/server' do
    # Stackeye::Services::Hardware.set
    # data = Stackeye::Services::Hardware.get

    erb(:"monitors/server", locals: { data: [1,2,3] })
  end

end
