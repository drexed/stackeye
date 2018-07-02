$LOAD_PATH << File.expand_path(File.dirname(__FILE__)) + '/lib'

require 'stackeye'
Stackeye::Application.run!
