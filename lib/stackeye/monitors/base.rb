# frozen_string_literal: true

module Stackeye
  module Monitors
    class Base

      def initialize
        @data = { timestamp: Time.now.to_s }
      end

      def filepath
        @filepath ||= begin
          path = Stackeye::Tools::Database::DATA_PATH
          name = self.class.name.split('::').last.downcase

          "#{path}/#{name}.json"
        end
      end

      def get
        Stackeye::Tools::Database.get(filepath)
      end

      def set
        generate_data
        return if @data.empty?

        Stackeye::Tools::Database.set(filepath, @data)
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
