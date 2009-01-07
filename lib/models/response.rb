class Response
  include DataMapper::Resource
  property :id,       Integer, :serial => true
  property :request,  String
  property :keywords, String
  property :wine_id,  Integer

  belongs_to :wine

  def suggestion
    self.wine = lookup_wine unless wine
    save
    return wine
  end

  private
  def lookup_wine
    keyword_list = self.request.split(" ").map do |term|
      t = SearchTerm.first(:term => term)
      t.keywords if t
    end
    keyword_list = keyword_list.flatten.compact
    update_my_keywords(keyword_list)
    wine = search_result(self.keywords)
    wine = search_result(default_search) unless wine
    return wine
  end

  def search_result(search_string)
    wines = Wine.search(:conditions => ["@full_description \"#{search_string}\"/2"])
    #wines = Wine.search(:full_description => search_string.split(" ")[0])
    wines.length > 0 ? wines[0] : nil
  end

  def update_my_keywords(keywords)
    self.keywords = keywords.inject(""){ |s, keyword| s = "#{s} #{keyword.term}"}.strip
  end

  def default_search
    "full"
  end
end
