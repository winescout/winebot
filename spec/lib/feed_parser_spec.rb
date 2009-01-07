require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe FeedParser do 
  before do 
    @item = mock("RssItem")
  end
  it "should default to true for is_wine_review?" do 
    FeedParser.new(@item).is_wine_review?.should == true
  end
end
