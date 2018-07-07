# frozen_string_literal: true

%w[base metrics].each do |filename|
  require_relative "#{filename}"
end
