require 'rake'
require(File.join(File.dirname(__FILE__), 'winebot'))
require(File.join(File.dirname(__FILE__), 'monopolybot'))

task :listen do 
  Winebot.runner
end

task :check_feeds do 
  Winebot.db_setup
  Feed.monitor_all
end

namespace :solr do 
  desc 'Starts Solr'
  task :start do 
    begin
      n = Net::HTTP.new('localhost', Winebot::SOLR_PORT)
      n.request_head('/').value
      
    rescue Net::HTTPServerException #responding
      puts "Port #{Winebot::SOLR_PORT} in use" and return
      
    rescue Errno::ECONNREFUSED #not responding
      Dir.chdir(Winebot::SOLR_PATH) do
        pid = fork do
          #STDERR.close
          `java -Djetty.port=#{Winebot::SOLR_PORT} -jar start.jar`
        end
        sleep(5)
        File.open(Winebot::SOLR_PID, "w"){ |f| f << pid}
        puts "Solr started successfully on #{Winebot::SOLR_PORT}, pid: #{pid}."
      end
    end
  end
end

desc 'Tasks to run the Monopolybot'
namespace :monopolybot do
  desc 'start up the listener'
  task :listen do 
    Monopolybot.runner
  end
end
