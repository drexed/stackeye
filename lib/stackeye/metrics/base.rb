# frozen_string_literal: true

module Stackeye
  module Metrics
    class Base

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

        @mean[key] = pluck(key).sum / pluck(key).length.to_f
      end

      class << self
        %i[filepath set get].each do |name|
          define_method(name) do
            klass = new
            klass.send(name)
          end
        end

        %i[pluck mean].each do |name|
          define_method(name) do |key|
            klass = new
            klass.send(name, key)
          end
        end
      end

    end
  end
end
