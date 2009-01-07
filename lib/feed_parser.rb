class FeedParser
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def is_wine_review?
    true #this is for feeds that aren't always wine reviews, we can weed out the noise
  end

  def unique_key
    raise "unique_key accessor Not Implimented"
  end
  
  def text 
    raise "text accessor Not Implimented"
  end

  def full_description
    raise "full_description accessor Not Implimented"
  end

  def url
    raise "url accessor Not Implimented"
  end
end
