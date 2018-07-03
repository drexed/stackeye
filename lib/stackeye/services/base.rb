# frozen_string_literal: true

module Stackeye
  module Services
    class Base

      def initialize
        @data = { timestamp: Time.now.to_s }
      end

      def filepath
        path = Stackeye::Tools::Database::DATA_PATH
        name = self.class.name.split('::').last.downcase

        "#{path}/#{name}.json"
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

      private

      def execute(name, cmds)
        puts Stackeye::Tools::Os.platform.inspect
        puts cmds[Stackeye::Tools::Os.platform].strip.inspect

        result = %x[ #{cmds[Stackeye::Tools::Os.platform]} ]
        return 0.0 if result.nil?

        @data[name] = result.to_f
      end

    end
  end
end
