# frozen_string_literal: true

module Stackeye
  module Metrics
    class All

      def initialize; end

      def set
        Stackeye.configuration.metrics.each do |metric|
          klass = "Stackeye::Metrics::#{modulize(metric)}"
          Module.const_get(klass).set
        end
      end

      class << self
        def set
          klass = new
          klass.set
        end
      end

    end
  end
end
