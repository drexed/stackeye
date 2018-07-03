# frozen_string_literal: true

require 'rufus-scheduler'

module Stackeye
  module Tools
    class Schedule

      TYPES ||= %i[cron every].freeze

      def initialize
        @scheduler = Rufus::Scheduler.new
      end

      TYPES.each do |name|
        define_method(name) do |interval, &block|
          @scheduler.cron(interval) { block.call }
        end
      end

      class << self
        TYPES.each do |name|
          define_method(name) do
            klass = new
            klass.send(name)
          end
        end
      end

    end
  end
end
