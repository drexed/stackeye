# frozen_string_literal: true

require 'stackeye/version'

%w[os cli schedule database].each do |filename|
  require "stackeye/tools/#{filename}"
end

%w[base hardware].each do |filename|
  require "stackeye/monitors/#{filename}"
end

require 'stackeye/application'
