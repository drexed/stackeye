# frozen_string_literal: true

%w[os cli database].each do |filename|
  require_relative filename
end
