require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Response do 
  before do 
    @response = Response.new(:request => "stopword keyword")
    SearchTerm.stub!(:first).with(:term => "stopword")
    @search_term = SearchTerm.new
    @keyword_1 = Keyword.new
    @keyword_1.stub!(:term).and_return("first_keyword")
    @keyword_2 = Keyword.new
    @keyword_2.stub!(:term).and_return("second_keyword")
    @search_term.stub!(:keywords).and_return([@keyword_1, @keyword_2])
    SearchTerm.stub!(:first).with(:term => "keyword").and_return(@search_term)
    
    @wine = Wine.new
    Wine.stub!(:search).and_return([@wine])
  end

  describe "search_string" do 
    it "should lookup significant words in request" do 
      SearchTerm.should_receive(:first).with(:term => "stopword")
      SearchTerm.should_receive(:first).with(:term => "keyword")
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
      Wine.should_receive(:search).with(:full_description => "first_keyword second_keyword").and_return([])
      @response.should_receive(:default_search).and_return("brut")
      Wine.should_receive(:search).with(:full_description => "brut")
      @response.suggestion
    end
  end
end
