class SearchTerm
  include DataMapper::Resource

  property :id,   Integer, :serial => true
  property :term, String, :index => :unique
  
  has n, :keyword_associations
  has n, :keywords, :through => :keyword_associations
end
