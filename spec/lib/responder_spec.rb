require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Responder do 
  before do 
    @response = Response.new
    @wine = Wine.new
    @wine.stub!(:text).and_return("text")
    @wine.stub!(:url).and_return("http://www.wine.com")
    @response.stub!(:suggestion).and_return(@wine)
    Response.stub!(:new).and_return(@response)
  end

  it "should create a new respone" do 
    Response.should_receive(:new).and_return(@response)
    Responder.new("dinner")
  end

  describe "to_s" do 
    before do 
      @responder = Responder.new("dinner")
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
