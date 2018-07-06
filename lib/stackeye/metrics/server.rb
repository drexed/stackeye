# frozen_string_literal: true

module Stackeye
  module Metrics
    class Server < Stackeye::Metrics::Base

      def generate_data
        generate_cpu_loadavg
        generate_cpu_utilization
        generate_memory_utilization
        generate_process_utilization
        generate_swap_utilization
        generate_volume_utilization
      end

      private

      def generate_cpu_loadavg
        { cpu_load_1m: 1, cpu_load_5m: 2, cpu_load_15m: 3 }.each do |name, col|
          cmd = "cat /proc/loadavg | awk '{ print $#{col} }'"
          @data[name] = Stackeye::Tools::Cli.execute(cmd).strip.to_f
        end
      end

      def generate_cpu_utilization
        cmd = "ps -Ao %cpu | awk '{ s += $1 } END { print s }'"
        @data[:cpu_utilization] = Stackeye::Tools::Cli.execute(cmd).strip.to_f
      end

      def generate_process_utilization
        { cpu: 'pcpu', memory: 'pmem' }.each do |label, sort|
          cmd = "ps -Ao user,uid,comm,pid,pcpu,pmem,tty --sort=-#{sort} | head -n 11"
          processes = Stackeye::Tools::Cli.execute(cmd)
          key = "#{label}_processes".to_sym

          @data[key] = []
          processes.split("\n").each_with_index do |process, i|
            next if i.zero?

            @data[key] << process.strip.gsub(/\s+/, ' ').split(' ')
          end
        end
      end

      def generate_memory_utilization
        { memory_free: 4, memory_total: 2, memory_used: 3 }.each do |name, col|
          cmd = "/usr/bin/free | head -n 2 | tail -n 1 | awk '{ print $#{col} }'"
          @data[name] = Stackeye::Tools::Cli.execute(cmd).strip.to_f
        end
      end

      def generate_swap_utilization
        { swap_free: 4, swap_total: 2, swap_used: 3 }.each do |name, col|
          cmd = "/usr/bin/free | tail -n 1 | awk '{ print $#{col} }'"
          @data[name] = Stackeye::Tools::Cli.execute(cmd).strip.to_f
        end
      end

      def generate_volume_utilization
        { disk_free: 4, disk_total: 2, disk_used: 3 }.each do |name, col|
          cmd = "/bin/df --total | tail -n 1 | awk '{ print $#{col} }'"
          @data[name] = Stackeye::Tools::Cli.execute(cmd).strip.to_f
        end
      end

    end
  end
end
