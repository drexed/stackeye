# frozen_string_literal: true

%w[base server mysql all].each do |filename|
  require_relative filename
end
