# frozen_string_literal: true

%w[version application].each do |filename|
  require "stackeye/#{filename}"
end
