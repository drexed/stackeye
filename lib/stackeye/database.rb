# frozen_string_literal: true

require 'json'

module Stackeye
  class Database

    DATA_PATH ||= File.expand_path('../../data', File.dirname(__FILE__)).freeze
    DATA_ROWS ||= 43_200

    def self.get(filepath)
      path = File.expand_path(filepath)
      json = []

      File.foreach(path) do |line|
        json << JSON.parse(line)
      end

      json
    end

    def self.set(filepath, hash)
      file = File.expand_path(filepath)
      json = JSON.generate(hash)

      File.open(file, 'a') do |outfile|
        outfile.puts json
      end
    end

    def self.truncate
      Dir.foreach(DATA_PATH) do |filename|
        next if filename.start_with?('.')

        file = File.expand_path("data/#{filename}")
        temp = IO.readlines(file)[-DATA_ROWS..-1]
        next if temp.nil? || temp.length == DATA_ROWS

        File.open(file, 'w') do |outfile|
          outfile.truncate(0)
          temp.each { |line| outfile.puts line }
        end
      end
    end

  end
end
