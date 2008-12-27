require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Winebot::Responder do 
  before do 
    @response = Winebot::Response.new
    @wine = Winebot::Wine.new
    @wine.stub!(:text).and_return("text")
    @wine.stub!(:url).and_return("http://www.wine.com")
    @response.stub!(:wine).and_return(@wine)
    Winebot::Response.stub!(:new).and_return(@response)
  end

  it "should create a new respone" do 
    Winebot::Response.should_receive(:new).and_return(@response)
    Winebot::Responder.new("dinner")
  end

  describe "to_s" do 
    before do 
      @responder = Winebot::Responder.new("dinner")
    end

    it "should get wine's text" do 
      @wine.should_receive(:text)
      @responder.to_s
    end

    it "should get wine's url" do 
      @wine.should_receive(:url)
      @responder.to_s
    end
  end
end
