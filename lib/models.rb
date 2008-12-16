module Winebot
  class Wine
    include DataMapper::Resource
    is :searchable, :repository => :search
  
    property :id,         Integer, :serial => true
    property :text,       String
    property :full_description, String
    property :url,        String
    property :created_at, DateTime
    has n, :suggestions
    has n, :entrees, :through => :suggestions
  end
  
  class Entree
    include DataMapper::Resource
    property :id,         Integer, :serial => true
    property :name,       String
    property :created_at, DateTime
    has n, :suggestions
    has n, :wines, :through => :suggestions
  end
  
  class Suggestion
    include DataMapper::Resource
    property :id,         Integer, :serial => true
    property :created_at, DateTime
    property :is_active,  Boolean
    belongs_to :entree
    belongs_to :wine
  end
end
