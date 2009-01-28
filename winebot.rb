require File.join(File.dirname(__FILE__), "twitterbot")

module Winebot

  SOLR_PORT = configatron.solr_port
  SOLR_PATH = configatron.solr_path
  SOLR_PID = configatron.solr_pid

  def self.feed_queue
    unless @beanstalk 
      @beanstalk = Beanstalk::Pool.new(['localhost:11300'])
      #@beanstalk.watch('feed_queue')
      #@beanstalk.use('feed_queue')
      #@beanstalk.ignore('default')
    end
    return @beanstalk
  end
  
  def self.last_id
    Twitter::Search.new.from(configatron.twittername).per_page(1).fetch["max_id"]
  end
  
  def self.db_setup
    DataMapper.setup(:default, "#{configatron.db_adapter}://#{configatron.db_username}:#{configatron.db_password}@#{configatron.db_server}/#{configatron.db_name}")
    DataMapper.setup(:search, { 
                       :adapter => "solr",
                       :host    => "localhost",
                       :port    => "8983",
                       :index   => "/solr"})
  end

  def self.runner
    self.db_setup
    loop do 
      Twitter::Search.new.since(self.last_id).to(configatron.twittername).each do |new_request|
        self.send_response(new_request)
      end
      sleep 8
    end
  end
  
  def self.send_response(request)
    responder = Twitter::Base.new(configatron.twittername, configatron.password)
    responder.update("@#{request["from_user"]} #{self.response(request)}")
    #responder.follow(request["from_user"])
  end
  
  def self.response(request)
    return WinebotResponse.create(:request => request["text"])
  end
end

#Winebot.runner
