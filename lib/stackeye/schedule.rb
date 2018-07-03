# frozen_string_literal: true

require 'rufus-scheduler'

module Stackeye
  class Schedule

    def self.every(interval, &block)
      scheduler = Rufus::Scheduler.new
      scheduler.every(interval) { block.call }
    end

    def self.cron(interval, &block)
      scheduler = Rufus::Scheduler.new
      scheduler.cron(interval) { block.call }
    end

  end
end
