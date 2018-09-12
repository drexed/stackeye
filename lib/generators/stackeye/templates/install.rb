# frozen_string_literal: true

Stackeye.configure do |config|
  config.max_data = 288
  config.metrics = %w[server mysql]
  config.credentials = {}
end
