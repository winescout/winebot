require 'rake'
require(File.join(File.dirname(__FILE__), 'winebot'))

task :check_feeds do 
  Winebot.db_setup
  Winebot::Feed.monitor_all
end
