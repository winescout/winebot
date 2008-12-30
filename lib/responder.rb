class Responder
  def initialize(input)
    @input = input
    @response = Response.new(:request => input)
  end

  def to_s 
    "#{@response.suggestion.text} How about this wine?- #{@response.suggestion.url}"
  end
end
