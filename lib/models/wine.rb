class Wine
  include DataMapper::Resource
  is :searchable, :repository => :search

  property :id,         Integer, :serial => true
  property :unique_key, String
  property :text,       String, :length => 140
  property :full_description, String, :length => 1000
  property :url,        String, :length => 255
  property :created_at, DateTime

  has n, :responses

  validates_is_unique :unique_key
end
