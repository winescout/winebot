require 'rake'
require(File.join(File.dirname(__FILE__), 'winebot'))

task :listen do 
  Winebot.runner
end

task :check_feeds do 
  Winebot.db_setup
  Feed.monitor_all
end

