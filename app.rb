# frozen_string_literal: true

$LOAD_PATH << File.expand_path(__dir__) + '/lib'

require 'stackeye'
Stackeye::Application.run!
