require 'rss'
require 'open-uri'

module Winebot
  class Feed
    include DataMapper::Resource
    property :id, Integer, :serial => true
    property :url, String, :length => 255
    property :feed_handler, String #handler class to pass instances off to for parsing

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
    end

    private
    def items
      RSS::Parser.parse(self.url).items
    end
  end
end
