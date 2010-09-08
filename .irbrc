require 'rubygems'
require 'irb/completion'
require 'pp'

# view sql when script/consle
# require "active_record"
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# http://irb-history.rubyforge.org/rdoc/
# require 'irb/history'
# IRB::History.start_client

require 'wirble'
Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true
