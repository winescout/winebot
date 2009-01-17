class Wine
  include DataMapper::SolrResource
  def self.default_repository_name
    :search
  end

  property :id,               Integer
  property :url,              String, :length => 255
  property :unique_key,       String, :length => 50, :key => true,
  property :text,             String, :length => 140
  property :full_description, String, :length => 1000
  property :created_at,       DateTime

end
