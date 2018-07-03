# frozen_string_literal: true

module Stackeye
  module Services
    class Hardware < Stackeye::Services::Base

      def generate_data
        generate_cpu_loadavg
        generate_cpu_utilization
      end

      private

      def generate_cpu_loadavg
        { cpu_load_1m: 1, cpu_load_5m: 2, cpu_load_15m: 3 }.each do |name, col|
          @data[name] = Stackeye::Tools::Cli.execute({
            linux: "cat /proc/loadavg | awk '{ print $#{col} }'",
            mac: "sysctl -n vm.loadavg | awk '{ print $#{col + 1} }'"
          }).strip.to_f
        end
      end

      def generate_cpu_utilization
        @data[:cpu_utilization] = Stackeye::Tools::Cli.execute({
          linux: "ps -A -o %cpu | awk '{ s += $1 } END { print s }'",
          mac: "ps -A -o %cpu | awk '{ s += $1 } END { print s }'"
        }).strip.to_f
      end

      def mem_data

      end

      def hdd_data

      end

    end
  end
end
