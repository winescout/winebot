module Winebot
  class Feed
    include DataMapper::Resource
    property :id, Integer, :serial => true
    property :url, String
    property :feed_handler, String #handler class to pass instances off to for parsing
  end
end
