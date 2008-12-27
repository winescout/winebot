require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Winebot::Response do 
  before do 
    @response = Winebot::Response.new(:request => "stopword keyword")
    Winebot::SearchTerm.stub!(:first).with(:term => "stopword")
    @search_term = Winebot::SearchTerm.new
    @keyword_1 = Winebot::Keyword.new
    @keyword_1.stub!(:term).and_return("first_keyword")
    @keyword_2 = Winebot::Keyword.new
    @keyword_2.stub!(:term).and_return("second_keyword")
    @search_term.stub!(:keywords).and_return([@keyword_1, @keyword_2])
    Winebot::SearchTerm.stub!(:first).with(:term => "keyword").and_return(@search_term)
    
    @wine = Winebot::Wine.new
    Winebot::Wine.stub!(:search).and_return([@wine])
  end

  describe "search_string" do 
    it "should lookup significant words in request" do 
      Winebot::SearchTerm.should_receive(:first).with(:term => "stopword")
      Winebot::SearchTerm.should_receive(:first).with(:term => "keyword")
      @response.suggestion
    end

    it "search wines based on keywords from search terms" do 
      @search_term.should_receive(:keywords).and_return([@keyword_1, @keyword_2])
      @response.suggestion
    end

    it "should set its keyword string" do 
      @response.should_receive(:keywords=).with("first_keyword second_keyword")
      @response.suggestion
    end
    
    it "should do default search if can't find wine" do 
      Winebot::Wine.should_receive(:search).with(:full_description => "first_keyword second_keyword").and_return([])
      @response.should_receive(:default_search).and_return("brut")
      Winebot::Wine.should_receive(:search).with(:full_description => "brut")
      @response.suggestion
    end
  end
end
