# frozen_string_literal: true

module Stackeye
  class Configuration

    MAX_DATA ||= 288
    METRICS ||= %w[server mysql].freeze

    attr_accessor :credentials, :metrics

    def initialize
      @max_data = MAX_DATA
      @metrics = METRICS
      @credentials = {}
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
