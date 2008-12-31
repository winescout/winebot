class GenericRssFeeder < FeedParser
  def unique_key
    Digest::SHA1.hexdigest(self.item.title)
  end

  def text
    self.item.title
  end

  def full_description
    self.item.description
  end

  def url
    self.item.link
  end
end
