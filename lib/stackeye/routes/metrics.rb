# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

  # before do
  #   @flash = session.delete(:flash)
  # end

  get '/server' do
    @title = 'Server'
    @metrics = Stackeye::Metrics::Server.new
    erb(:"metrics/server/index")
  end

end
