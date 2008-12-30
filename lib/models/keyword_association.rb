class KeywordAssociation
  include DataMapper::Resource
  property :id,             Integer, :serial => true
  property :search_term_id, Integer
  property :keyword_id,     Integer

  belongs_to :search_term
  belongs_to :keyword

  validates_is_unique :keyword_id, :scope => :search_term_id
end
