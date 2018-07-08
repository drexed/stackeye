# frozen_string_literal: true

class Stackeye::Application < Sinatra::Base

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
