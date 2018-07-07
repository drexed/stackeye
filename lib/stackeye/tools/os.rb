# frozen_string_literal: true

require 'rbconfig'

module Stackeye
  module Tools
    class Os

      HOST_OS ||= {
        bsd: /bsd/,
        freebsd: /freebsd/,
        linux: /linux|cygwin/,
        mac: /mac|darwin/,
        solaris: /solaris|sunos/,
        windows: /mswin|win|mingw/
      }.freeze

      def initialize
        @config = RbConfig::CONFIG['host_os']
      end

      def platform
        HOST_OS.keys.detect { |name| send("#{name}?") }
      end

      HOST_OS.each do |name, regex|
        define_method("#{name}?") do
          @config =~ regex
        end
      end

      class << self
        def platform
          klass = new
          klass.platform
        end

        HOST_OS.each do |name, _regex|
          define_method("#{name}?") do
            klass = new
            klass.send("#{name}?")
          end
        end
      end

    end
  end
end
