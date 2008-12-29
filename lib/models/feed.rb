require 'rss'
require 'open-uri'

class Feed
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :url, String, :length => 255
  property :feed_handler, String #handler class to pass instances off to for parsing
  property :run_frequency, String, :default => "daily"

  def self.monitor_all
    Feed.all do |feed|
      feed.fetch_wines
    end
    loop do 
      job = Winebot.feed_queue.reserve
      details = job.ybody
      feed = Feed.first(:id => details[:id])
      feed.fetch_wines
    end
  end

  def fetch_wines
    i = items
    klass = eval self.feed_handler
    items.collect do |item|
      p = klass.new(item)
      Wine.create(:unique_key       => p.unique_key,
                  :text             => p.text,
                  :full_description => p.full_description,
                  :url              => p.url)
    end
    reschedule
  end
  
  def reschedule
    Winebot.feed_queue.yput({:id => self.id}, 65536, delay)
  end

  private
  def delay
    delay = case run_frequency
              when 'daily': 86500 #1 day + 100 seconds
              else 86500 #1 day + 100 seconds
            end
  end

  def items
    RSS::Parser.parse(self.url).items
  end
end
