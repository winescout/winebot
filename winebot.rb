require 'rubygems'
require 'twitter'
require 'dm-core'
#require 'dm-more'
require 'dm-is-searchable'
require 'dm-sphinx-adapter'
require 'configatron'

require 'config'
require 'lib/models/wine'
require 'lib/models/feed'
require 'lib/responder'
require 'lib/ws_daily_feeder'

module Winebot
  def self.last_id
    id = 1052887557 #just a default
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
    #DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/winebot.db")
    DataMapper.setup(:default, "mysql:///winebot")
    DataMapper.setup(:search, 'sphinx://localhost:3312')

    Twitter::Search.new.since(self.last_id).to(configatron.twittername).each do |new_request|
      self.send_response(new_request)
      self.set_last_id(new_request["id"])
    end
  end
  
  def self.send_response(request)
    responder = Twitter::Base.new(configatron.twittername, configatron.password)
    responder.update("@#{request["from_user"]} #{self.response(request)}")
  end
  
  def self.response(request)
    return Responder.new(request["text"])
  end
end

#Winebot.runner
