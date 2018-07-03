# frozen_string_literal: true

module Stackeye
  module Services
    class Hardware < Stackeye::Services::Base


      def generate_data
        @data[:test] = 'sample'
      end

      private

      def cpu_data
        {}
      end

      def mem_data

      end

      def hdd_data

      end

    end
  end
end
