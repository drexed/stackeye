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

      def get
        return @get if defined?(@get)

        @get ||= Stackeye::Tools::Database.get(filepath)
      end

      def set
        generate_data
        return if @data.empty?

        Stackeye::Tools::Database.set(filepath, @data)
      end

      def pluck(key)
        @pluck ||= {}
        return @pluck[key] if @pluck.key?(key)

        @pluck[key] = get.collect { |hash| hash[key] }
      end

      class << self
        def pluck(key)
          klass = new
          klass.pluck(key)
        end

        %i[filepath get set].each do |name|
          define_method(name) do
            klass = new
            klass.send(name)
          end
        end
      end

    end
  end
end
