# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

  get '/server' do
    verify_distro_and_os!

    @title = 'Server'
    @metrics = Stackeye::Metrics::Server.new

    erb(:"metrics/server/index")
  end

end
