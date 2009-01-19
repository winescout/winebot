require 'twitterbot'

module Monopolybot
  
  CARDS = File.join(File.dirname(__FILE__), 'lib', 'fixtures', 'chance_cards.yml')

  def self.last_id
    Twitter::Search.new.from(configatron.monopolybot_twittername).per_page(1).fetch["max_id"]
  end
  
  def self.db_setup
    DataMapper.setup(:default, "#{configatron.db_adapter}://#{configatron.db_username}:#{configatron.db_password}@#{configatron.db_server}/#{configatron.db_name}")
  end

  def self.runner
    self.db_setup
    loop do 
      Twitter::Search.new("monopoly").since(self.last_id).each do |new_request|
        self.send_response(new_request)
      end
      sleep 4
    end
  end
  
  def self.send_response(request)
    s = "@#{request["from_user"]} #{self.response(request)}"
    puts "{s.size}"
    #responder = Twitter::Base.new(configatron.monopolybot_twittername, configatron.monopolybot_password)
    #responder.update("@#{request["from_user"]} #{self.response(request)}")
    #responder.follow(request["from_user"])
  end
  
  def self.response(request)
    return MonopolybotResponse.new(request["text"])
  end
end

#Winebot.runner
