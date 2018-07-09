# frozen_string_literal: true

require 'json'

module Stackeye
  module Tools
    class Database

      MAX_DATA ||= Stackeye.configuration.max_data
      DATA_PATH ||= File.expand_path('stackeye')

      def initialize(filepath)
        @filepath = File.expand_path(filepath)
      end

      def get
        json = []
        return json unless File.file?(@filepath)

        File.foreach(@filepath).with_index do |line, i|
          json << JSON.parse(line)

          break if i == MAX_DATA
        end
        json
      end

      def set(hash)
        Dir.mkdir(DATA_PATH) unless File.directory?(DATA_PATH)

        File.open(@filepath, 'a+') do |outfile|
          outfile.puts JSON.generate(hash)
        end
      end

      def truncate
        Dir.foreach(DATA_PATH) do |filename|
          next if filename.start_with?('.')

          file = "#{DATA_PATH}/#{filename}"
          temp = IO.readlines(file)[-MAX_DATA..-1]
          next if temp.nil? || (temp.length < MAX_DATA)

          File.open(file, 'w') do |outfile|
            temp.each { |line| outfile.puts line }
          end
        end
      end

      class << self
        def get(filepath)
          klass = new(filepath)
          klass.get
        end

        def set(filepath, hash)
          klass = new(filepath)
          klass.set(hash)
        end

        def truncate
          klass = new('')
          klass.truncate
        end
      end

    end
  end
end
