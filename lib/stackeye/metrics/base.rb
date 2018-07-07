# frozen_string_literal: true

module Stackeye
  module Metrics
    class Base

      MB ||= 1024.0
      GB ||= MB**2

      def initialize
        @data = { timestamp: Time.now.to_i }
      end

      def filepath
        return @filepath if defined?(@filepath)

        @filepath ||= begin
          path = Stackeye::Tools::Database::DATA_PATH
          name = self.class.name.split('::').last.downcase

          "#{path}/#{name}.json"
        end
      end

      def set
        generate_data
        return if @data.empty?

        Stackeye::Tools::Database.set(filepath, @data)
      end

      def get
        return @get if defined?(@get)

        @get ||= Stackeye::Tools::Database.get(filepath)
      end

      def pluck(key)
        @pluck ||= {}
        return @pluck[key] if @pluck.key?(key)

        @pluck[key] = get.collect { |hash| hash[key] }
      end

      def mean(key)
        @mean ||= {}
        return @mean[key] if @mean.key?(key)

        values = pluck(key)
        return @mean[key] = 0.0 if values.empty?

        @mean[key] = values.sum / values.length.to_f
      end

      # rubocop:disable Metrics/AbcSize
      def median(key)
        @median ||= {}
        return @median[key] if @median.key?(key)

        values = pluck(key)
        return @median[key] = 0.0 if values.empty?

        values_sorted = values.sort
        values_halved = values.length / 2.0
        values_halved_sorted = values_sorted[values_halved]
        return @median[key] = values_halved_sorted unless (values.length % 2).zero?

        @median[key] = (values_sorted[values_halved - 1.0] + values_halved_sorted) / 2.0
      end
      # rubocop:enable Metrics/AbcSize

      def mode(key)
        @mode ||= {}
        return @mode[key] if @mode.key?(key)

        values = pluck(key)
        return @mode[key] = 0.0 if values.empty?

        values_distro = values.each_with_object(Hash.new(0)) { |val, hsh| hsh[val] += 1 }
        values_top_two = values_distro.sort_by { |_, val| -val }.take(2)
        @mode[key] = values_top_two.first.first
      end

      def range(key)
        @range ||= {}
        return @range[key] if @range.key?(key)

        values = pluck(key)
        return @range[key] = 0.0 if values.empty?

        values_sorted = values.sort
        @mode[key] = values_sorted.last - values_sorted.first
      end

      class << self
        %i[filepath set get].each do |name|
          define_method(name) do
            klass = new
            klass.send(name)
          end
        end

        %i[pluck mean median mode range].each do |name|
          define_method(name) do |key|
            klass = new
            klass.send(name, key)
          end
        end
      end

    end
  end
end
