module Winebot
  class Responder
    def initialize(input)
      @input = input
      @response = Response.new(input)
    end

    def to_s 
      "#{@response.wine.text} - #{@response.wine.url}"
    end
  end
end
