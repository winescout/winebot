class Wine
  include DataMapper::Resource
  def self.default_repository_name
    :search
  end

  property :id,               Integer
  property :url,              String, :key => true, :length => 255
  property :text,             String, :length => 140
  property :full_description, String, :length => 1000
  property :created_at,       DateTime

end
