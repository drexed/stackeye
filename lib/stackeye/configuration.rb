# frozen_string_literal: true

module Stackeye
  class Configuration

    METRICS ||= %w[server mysql].freeze

    attr_accessor :metrics

    def initialize
      @metrics = METRICS
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield(configuration)
  end

end
