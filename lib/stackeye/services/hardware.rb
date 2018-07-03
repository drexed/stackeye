# frozen_string_literal: true

module Stackeye
  module Services
    class Hardware < Stackeye::Services::Base


      def generate_data
        generate_cpu_data
      end

      private

      def generate_cpu_data
        { cpu_load_1m: 1, cpu_load_5m: 2, cpu_load_15m: 3 }.each do |met, col|
          @data[met] = `cat /proc/loadavg | awk '{ print $#{col} }'`
        end
      end

      def mem_data

      end

      def hdd_data

      end

    end
  end
end
