# frozen_string_literal: true

module Stackeye
  class Configuration

    attr_accessor :metrics

    def initialize
      @metrics = %w[mysql]
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
