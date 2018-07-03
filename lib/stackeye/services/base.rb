# frozen_string_literal: true

module Stackeye
  module Services
    class Base
      class << self

        def get
          Stackeye::Database.get(filepath)
        end

        def set
          Stackeye::Database.set(filepath, data)
        end

        def filepath
          path = Stackeye::Database::DATA_PATH
          name = self.name.split('::').last.downcase

          "#{path}/#{name}.json"
        end

      end
    end
  end
end
