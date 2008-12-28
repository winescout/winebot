require 'rubygems'
require 'twitter'
require 'dm-core'
#require 'dm-more'
require 'dm-is-searchable'
require 'dm-sphinx-adapter'
require 'configatron'

require 'config/config'
require 'lib/models/wine'
require 'lib/models/feed'
require 'lib/models/response'
require 'lib/models/keyword'
require 'lib/models/search_term'
require 'lib/models/keyword_association'
require 'lib/responder'
require 'lib/feed_parser'
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
  
  def self.db_setup
    DataMapper.setup(:default, "#{configatron.db_adapter}://#{configatron.db_username}:#{configatron.db_password}@#{configatron.db_server}/#{configatron.db_name}")
    DataMapper.setup(:search, 'sphinx://localhost:3312')
  end

  def self.runner
    self.db_setup
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
