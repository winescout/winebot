require File.join(File.dirname(__FILE__), 'spec_helper.rb')
describe Winebot do 
  before do 
    @search = Twitter::Search.new
    @search.stub!(:each).and_return([])
    Twitter::Search.stub!(:new).and_return(@search)
    Winebot.stub!(:send_response)
  end

  describe "scheduling" do 
    before do 
      @beanstalk = mock(Beanstalk,
                        :watch => nil,
                        :use => nil,
                        :ignore => nil)
      Beanstalk::Pool.stub!(:new).and_return(@beanstalk)
    end
    
    it "should build a new beanstalk" do 
      Beanstalk::Pool.should_receive(:new).and_return(@beanstalk)
      Winebot.feed_queue
    end
  end

end
