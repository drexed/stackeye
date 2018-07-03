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

      def posix?
        linux? || mac? || freebsd? || bsd? || solaris? || Process.respond_to?(:fork)
      end

      HOST_OS.each do |name, regex|
        define_method("#{name}?") do
          @config === regex
        end
      end

      class << self
        def posix?
          klass = new
          klass.posix?
        end

        HOST_OS.each do |name, _regex|
          define_method(name) do |filepath|
            klass = new
            klass.send(name)
          end
        end
      end

    end
  end
end
