require File.join(File.dirname(__FILE__), 'spec_helper.rb')
describe Winebot do 
  before do 
    @search = Twitter::Search.new
    @search.stub!(:each).and_return([])
    Twitter::Search.stub!(:new).and_return(@search)
    Winebot.stub!(:send_response)
  end

  describe "runner" do
    it "should  setup Twitter" do
      @search.should_receive(:each)
      Winebot.runner
    end
  end
end
