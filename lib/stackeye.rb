# frozen_string_literal: true

require 'stackeye/version'

%w[os cli database].each do |filename|
  require "stackeye/tools/#{filename}"
end

%w[base server].each do |filename|
  require "stackeye/metrics/#{filename}"
end

require 'stackeye/application'
