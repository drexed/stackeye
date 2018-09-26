# frozen_string_literal: true

# Awesome print
begin
  require 'awesome_print'

  AwesomePrint.irb!
rescue LoadError => err
  warn "Couldn't load awesome_print: #{err}"
end

# IRB
require 'irb/completion'

ARGV.concat %w[--readline --prompt-mode simple]

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('.irbrc_history')

# Rails
railsrc_path = File.expand_path('.irbrc_rails')

if (ENV['RAILS_ENV'] || defined?(Rails)) && File.exist?(railsrc_path)
  begin
    load railsrc_path
  rescue Exception => err
    warn "Could not load: #{railsrc_path} because of #{err}"
  end
end

# Object
class Object

  def interesting_methods
    case self.class
    when Class then public_methods.sort - Object.public_methods
    when Module then public_methods.sort - Module.public_methods
    else public_methods.sort - Object.new.public_methods
    end
  end

end
