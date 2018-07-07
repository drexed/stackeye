# frozen_string_literal: true

%w[base server all].each do |filename|
  require_relative filename
end
