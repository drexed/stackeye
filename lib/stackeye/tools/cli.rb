# frozen_string_literal: true

require 'open3'

module Stackeye
  module Tools
    class Cli

      def initialize(commands)
        @command = commands[Stackeye::Tools::Os.platform]
      end

      def execute
        output, _status = Open3.capture2(@command)
        output
      end

      class << self
        def execute(commands)
          klass = new(commands)
          klass.execute
        end
      end

    end
  end
end
