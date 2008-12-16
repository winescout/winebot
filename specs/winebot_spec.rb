require File.join(File.dirname(__FILE__), 'spec_helper.rb')
describe Winebot do 
  before do 
    Winebot.stub!(:send_response)
  end

  describe "runner" do
    it "should  setup Twitter" do
      Twitter::Search.should_receive(:new)
    end
  end
end
