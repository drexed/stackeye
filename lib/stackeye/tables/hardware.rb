# frozen_string_literal: true

module Stackeye
  module Tables
    class Hardware < Stackeye::Tables::Base

      set_table_name 'hardware'

      columns :cpu_1m, :cpu_5m, :cpu_15m

    end
  end
end
