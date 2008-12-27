module Winebot
  class Response
    include DataMapper::Resource
    property :id,       Integer, :serial => true
    property :request,  String
    property :keywords, String
    property :wine_id,  Integer

    has 1, :wine
  end
end
