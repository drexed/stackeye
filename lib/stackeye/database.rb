# frozen_string_literal: true

module Stackeye
  class Database

    def self.truncate
      file_path = File.expand_path('../../data', File.dirname(__FILE__))

      Dir.entries(file_path).each do |file|
        next if file.start_with?('.')

        file = File.expand_path("data/#{file}")
        File.truncate(file, 0)
      end
    end

  end
end
