module Winebot
  class Wine
    include DataMapper::Resource
    is :searchable, :repository => :search
  
    property :id,         Integer, :serial => true
    property :unique_key, String, :index => :unique
    property :text,       String
    property :full_description, String
    property :url,        String
    property :created_at, DateTime

    has n, :responses
  end
end
