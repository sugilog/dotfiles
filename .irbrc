require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.join ENV["HOME"], ".irb_history"

if ENV.include?("RAILS_ENV")
  if !defined? RAILS_DEFAULT_LOGGER
    require 'logger'
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end
end

local_conf = File.join ENV['HOME'], ".irbrc.local"

if File.exists?(local_conf)
  load local_conf
end
