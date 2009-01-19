require 'yaml'

class WinebotResponse
  include DataMapper::Resource
  property :id,       Integer, :serial => true
  property :request,  String
  property :keywords, String
  property :wine_unique_key, String

  belongs_to :wine

  def leadin
    "How about this wine?-"
  end

  def suggestion
    wine = lookup_wine
    wine_unique_key = wine.unique_key #record the association
    save
    return wine
  end

  def to_s 
    "#{leadin} #{suggestion.text} #{suggestion.url}"
  end

  private
  def lookup_wine
    keyword_list = self.request.split(" ").map do |term|
      t = SearchTerm.first(:term => term)
      t.keywords if t
    end
    keyword_list = keyword_list.flatten.compact
    update_my_keywords(keyword_list)
    Wine.first(:full_description => "#{keywords} #{default_search}")
  end

  def update_my_keywords(keywords)
    self.keywords = keywords.inject(""){ |s, keyword| s = "#{s} #{keyword.term}"}.strip
  end

  def default_search
    "full"
  end
end


class MonopolybotResponse
  class Card
    def text
      random_card["text"]
    end

    private
    def random_card
      cards = YAML.load_file(Monopolybot::CARDS)
      max = cards.count - 1
      cards.to_a[rand(max)][1]
    end
  end

  def initialize(args)
    @input = args[:request]
  end

  def leadin
    "You landed on Chance -"
  end

  def card
    Card.new
  end

  def to_s
    "#{leadin} #{card.text}"
  end
end

