# frozen_string_literal: true

module Stackeye
  module Metrics
    class Mysql < Stackeye::Metrics::Base

      def generate_data
        generate_processes
        generate_stats
      end

      private

      def generate_processes
        # TODO: generate processes
      end

      def generate_stats
        # TODO: generate stats
      end

    end
  end
end
