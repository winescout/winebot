require 'rubygems'
require 'twitter'
require 'dm-core'
require 'dm-validations'
require 'dm-solr-adapter'
require 'configatron'
require 'beanstalk-client'

require File.join(File.dirname(__FILE__), 'config', 'config')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'wine')
require File.join(File.dirname(__FILE__), 'lib','models', 'feed')
require File.join(File.dirname(__FILE__), 'lib', 'models','response')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'keyword')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'search_term')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'keyword_association')
require File.join(File.dirname(__FILE__), 'lib', 'responder')
require File.join(File.dirname(__FILE__), 'lib', 'feed_parser')
require File.join(File.dirname(__FILE__), 'lib', 'generic_rss_feeder')

module Winebot
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
      sleep 4
    end
  end
  
  def self.send_response(request)
    responder = Twitter::Base.new(configatron.twittername, configatron.password)
    responder.update("@#{request["from_user"]} #{self.response(request)}")
    responder.follow(request["from_user"])
  end
  
  def self.response(request)
    return Responder.new(request["text"])
  end
end

#Winebot.runner
