module Winebot
  class Response
    include DataMapper::Resource
    property :id,       Integer, :serial => true
    property :request,  String
    property :keywords, String
    property :wine_id,  Integer

    belongs_to :wine

    def suggestion
      self.wine = lookup_wine unless wine
      return wine
    end

    private
    def lookup_wine
      keyword_list = self.request.split(" ").map do |term|
        t = SearchTerm.first(:term => term)
        t.keywords if t
      end
      keyword_list.flatten!.compact!      
      update_my_keywords(keyword_list)
      
      wine = Wine.search(:full_description => self.keywords)
      wine = Wine.search(:full_description => default_search) unless wine
      return wine
    end

    def update_my_keywords(keywords)
      self.keywords = keywords.inject(""){ |s, keyword| s = "#{s} #{keyword.term}"}.strip
    end

    def default_search
      "brut"
    end
  end
end
