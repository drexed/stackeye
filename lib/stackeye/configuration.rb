# frozen_string_literal: true

# TODO: add filepath config

module Stackeye
  class Configuration

    METRICS ||= %w[server mysql].freeze

    attr_accessor :credentials, :metrics

    def initialize
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
