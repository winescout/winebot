class Responder
  def initialize(input)
    @input = input
    @response = Response.new(:request => input)
  end

  def to_s 
    "How about this wine?- #{@response.suggestion.text} #{@response.suggestion.url}"
  end
end
