require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe WinebotResponse do 
  before do 
    @response = WinebotResponse.new(:request => "stopword keyword",
                                    :keywords => "")
    SearchTerm.stub!(:first).with(:term => "stopword")
    @search_term = SearchTerm.new
    @keyword_1 = Keyword.new
    @keyword_1.stub!(:term).and_return("first_keyword")
    @keyword_2 = Keyword.new
    @keyword_2.stub!(:term).and_return("second_keyword")
    @search_term.stub!(:keywords).and_return([@keyword_1, @keyword_2])
    SearchTerm.stub!(:first).with(:term => "keyword").and_return(@search_term)
    
    @wine = Wine.new
    Wine.stub!(:all).and_return([@wine])
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

   it "should not do search with empty search_terms" do 
      @search_term.should_receive(:keywords).and_return([])
      @response.should_not_receive(:first_search_result).with("")
      @response.suggestion
    end
  end
end
