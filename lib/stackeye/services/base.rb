# frozen_string_literal: true

module Stackeye
  module Services
    class Base

      def initialize
        @data = { timestamp: Time.now.to_s }
      end

      def filepath
        path = Stackeye::Database::DATA_PATH
        name = self.class.name.split('::').last.downcase

        "#{path}/#{name}.json"
      end

      def get
        Stackeye::Database.get(filepath)
      end

      def set
        generate_data
        return if @data.empty?

        Stackeye::Database.set(filepath, @data)
      end

      class << self
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
