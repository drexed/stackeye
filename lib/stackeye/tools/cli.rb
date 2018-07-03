# frozen_string_literal: true

require 'open3'

module Stackeye
  module Tools
    class Cli

      def initialize(command)
        @command = command
      end

      def execute
        output, _status = Open3.capture2(@command)
        output
      end

      class << self
        def execute(command)
          klass = new(command)
          klass.execute
        end
      end

    end
  end
end
