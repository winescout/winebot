require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Winebot::WSDailyFeeder do 
  before do 
    @xml = ""
    @wine = Winebot::Wine.new
    Winebot::Wine.stub!(:create).and_return(@wine)
  end
end
