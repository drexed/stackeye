# frozen_string_literal: true

module Stackeye
  module Metrics
    class Mysql < Stackeye::Metrics::Base

      CREDENTIALS ||= {
        user: 'root',
        host: 'localhost',
        password: nil
      }.freeze

      def generate_data
        generate_stats
      end

      private

      # rubocop:disable Metrics/AbcSize
      def generate_stats
        cmd = "mysqladmin -u#{user} -h#{host} -p#{password} status"
        lines = Stackeye::Tools::Cli.execute(cmd).split("\n")
        stats = lines.last.strip.split('  ')

        stats.each do |stat|
          key, val = stat.split(': ')
          key = key.downcase.tr(' ', '_')
          key = 'velocity' if key == 'queries_per_second_avg'

          @data[key] = val.to_f.round(2)
        end
      end
      # rubocop:enable Metrics/AbcSize

      %i[host password user].each do |name|
        define_method(name) do
          credentials = Stackeye.configuration.credentials[:mysql]
          credentials[name] || CREDENTIALS[name]
        end
      end

    end
  end
end
