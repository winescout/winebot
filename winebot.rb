require 'rubygems'
require 'twitter'

module Winebot
  def self.last_id
    id = 1052887557
    File.open("./last_id", "r") do |f|
      id = f.read
    end rescue nil
    return id
  end

  def self.set_last_id id
    File.open("./last_id", "w") do |f|
      f.write(id)
    end
  end
  
  def self.runner
    Twitter::Search.new.since(self.last_id).to('testtobot').each do |new_request|
      self.send_response(new_request)
      self.set_last_id(new_request["id"])
    end
  end
  
  def self.send_response(request)
    responder = Twitter::Base.new('testtobot', 'lucky1')
    responder.update("@#{request["from_user"]} #{self.response(request)}")
  end
  
  def self.response(request)
    return Responder.new(request["text"]).to_s
  end

  class Responder
    def initialize(input)
      @input
    end

    def to_s #this is where the cleverness of the parser is revealed in a brililant wine choice
      "xxxyyyy"
    end
  end
end

Winebot.runner
