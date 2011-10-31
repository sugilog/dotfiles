require 'rubygems'
require 'irb/completion'

# http://irb-history.rubyforge.org/rdoc/
IRB.conf[:SAVE_HISTORY] = 1000

require 'wirble'
Wirble.init
Wirble.colorize

require 'active_record'
ActiveRecord::Base.logger = Logger.new(STDOUT)
