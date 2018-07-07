# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

  get '/server' do
    verify_distro_and_os!

    @metrics = Stackeye::Metrics::Server.new
    @title = 'Server'

    erb(:'metrics/server/index')
  end

  Stackeye.configuration.metrics.each do |metric|
    get "/#{metric}" do
      # verify_distro_and_os!

      klass = "Stackeye::Metrics::#{modulize(metric)}"
      @metrics = Module.const_get(klass).new
      @title = metric_name_decorator(metric)

      erb(:"metrics/#{metric}/index")
    end
  end

end
