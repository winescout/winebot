class Keyword
  include DataMapper::Resource

  property :id,   Integer, :serial => true
  property :term, String, :index => :unique

  has n, :keyword_associations
  has n, :search_terms, :through => :keyword_associations

  validates_is_unique :term
end
