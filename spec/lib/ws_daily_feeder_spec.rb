require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')
require 'digest/sha1'

describe Winebot::WSDailyFeeder do 
  before do 
    @item = mock("RSS parsed item",
                 :title => "title",
                 :link  => "url link",
                 :description => "desc",
                 :pubDate => Time.now)
    @feeder = Winebot::WSDailyFeeder.new(@item)
  end

  it "should parse unique_key" do 
    @feeder.unique_key.should == Digest::SHA1.hexdigest(@item.title)
  end

  it "should parse text" do 
    @feeder.text.should == @item.title
  end

  it "should parse full_description" do 
    @feeder.full_description.should == @item.description
  end
  
  it "should parse url" do 
    @feeder.url.should == @item.link
  end
end
