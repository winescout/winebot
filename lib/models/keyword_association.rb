class KeywordAssociation
  include DataMapper::Resource
  property :id,             Integer, :serial => true
  property :search_term_id, Integer
  property :keyword_id,     Integer
end
