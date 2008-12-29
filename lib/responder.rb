class Responder
  def initialize(input)
    @input = input
    @response = Response.new(:request => input)
  end

  def to_s 
    "#{@response.suggestion.text} - #{@response.suggestion.url}"
  end
end
