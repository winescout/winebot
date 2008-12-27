require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')
require 'rss'
require 'open-uri'

describe Winebot::Feed do 
  
  describe "fetch new" do 
    class TestHandler; end

    before do 
      @feed = Winebot::Feed.new(:url => "http://test.com/feed_url.xml")
      @feed = Winebot::Feed.new(:url => "http://www.winespectator.com/RSS/wod_rss/0,4007,,00.xml")
      @feed_content = File.read(File.join(File.dirname(__FILE__), '..', 'fixtures', 'ws_daily_feed.xml'))
      @parsed_items = RSS::Parser.parse(@feed_content).items
      @feed.stub!(:items).and_return(@parsed_items)
      @feed.stub!(:feed_handler).and_return("TestHandler")
      
      @handler = mock(TestHandler,
                      :unique_key => nil,
                      :text       => nil,
                      :full_description => nil,
                      :url        => nil)
      TestHandler.stub!(:new).and_return(@handler)

      Winebot::Wine.stub!(:create)
    end
    
    it "should pull the feed" do 
      @feed.should_receive(:items).and_return(@parsed_items)
      @feed.fetch_wines
    end

    it "should create a new handler for feed items" do 
      TestHandler.should_receive(:new).and_return(@handler)
      @feed.fetch_wines
    end

    it "should attempt to create a new wine for each item" do 
      Winebot::Wine.should_receive(:create)
      @feed.fetch_wines
    end
  end
end
