# frozen_string_literal: true

require 'sinatra/base'

require 'active_hash'

class Country < ActiveJSON::Base
  # set_root_path File.expand_path(File.dirname(__FILE__) + '/../../data')

  fields :name#, default: 'nan'
end

5.times do
  Country.add(name: 'fake')
  # c.save

  # Stackeye::Tables::Hardware.create(cpu_1m: "#{rand(0..999)}@email.com")
end

# Country.all.each do |country|
#   country.save
# end

puts Country.all.inspect

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
