# frozen_string_literal: true

module Stackeye
  module Metrics
    class All

      def initialize; end

      def set
        Stackeye::Metrics::Server.set
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
