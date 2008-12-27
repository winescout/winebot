module Winebot
  class FeedParser
    attr_accessor :item
    def self.parse(item)
      self.new(:item => item)
    end

    def unique_key
      raise "Not Implimented"
    end
    
    def text 
      raise "Not Implimented"
    end

    def full_description
      raise "Not Implimented"
    end

    def url
      raise "Not Implimented"
    end

    def created_at
      raise "Not Implimented"
    end
  end

  class WSDailyFeeder < FeedParser
    
  end
end
