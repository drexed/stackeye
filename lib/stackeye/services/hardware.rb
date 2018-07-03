# frozen_string_literal: true

module Stackeye
  module Services
    class Hardware < Stackeye::Services::Base
      class << self

        def data
          { sup: 'dude' }
        end

        private

        def privi

        end

      end
    end
  end
end
