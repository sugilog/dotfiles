require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

def y(obj)
  puts obj.to_yaml
end

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError => ex
  puts ex.message
end

if ENV.include?("RAILS_ENV")
  if !defined? RAILS_DEFAULT_LOGGER
    require 'logger'
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end

  begin
    #require 'hirb'
    #Hirb.enable
  rescue LoadError => ex
    puts ex.message
  end
else
  begin
    require 'fancy_irb'
    FancyIrb.start
  rescue LoadError => ex
    puts ex.message
  end
end

