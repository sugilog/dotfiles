require 'rubygems'
require 'irb/completion'
require 'pp'

# http://irb-history.rubyforge.org/rdoc/
IRB.conf[:SAVE_HISTORY] = 1000

require 'wirble'
Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

def log_to(stream = STDOUT)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end
