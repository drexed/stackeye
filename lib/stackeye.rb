# frozen_string_literal: true

%w[version configuration application].each do |filename|
  require "stackeye/#{filename}"
end

require 'generators/stackeye/install_generator'
