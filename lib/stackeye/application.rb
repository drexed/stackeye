# frozen_string_literal: true

require 'sinatra/base'


5.times do |i|
  Stackeye::Services::Hardware.set
end


# Stackeye::Database.truncate

# TODO: change to .cron('0 0 * * *')
# Stackeye::Schedule.every('1s') do
#   Stackeye::Database.truncate
# end

class Stackeye::Application < Sinatra::Base

  get '/' do
    erb(:index, locals: { clients: 'something' })
  end

end
