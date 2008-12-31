require 'rake'
require(File.join(File.dirname(__FILE__), 'winebot'))

task :listen do 
  Winebot.runner
end

task :check_feeds do 
  Winebot.db_setup
  Feed.monitor_all
end

task :reindex do 
  loop do 
    `/usr/local/sphinx/bin/indexer --rotate --all --config /usr/local/sphinx/etc/sphinx.conf`
    sleep 86400
  end
end
