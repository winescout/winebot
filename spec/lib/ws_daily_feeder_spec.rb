require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Winebot::WSDailyFeeder do 
  before do 
    @xml = ""
    @wine = Winebot::Wine.new
    Winebot::Wine.stub!(:create).and_return(@wine)
  end

  it "should take a chunk of xml"

  it "should create a wine" do 
    Winebot::Wine.should_receive(:create)
    Winebot::WSDailyFeeder.parse(@xml)
  end
end
