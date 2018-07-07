# frozen_string_literal: true

%w[base server].each do |filename|
  require_relative "#{filename}"
end
