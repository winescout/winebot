#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'winebot')
Winebot.db_setup

class UserInput
  attr_accessor :entered_string

  def initialize
    STDOUT.flush
    @entered_string = gets
  end

  def to_s
    @entered_string.strip
  end
end

loop do 
  print "User Entered Value:"
  u = UserInput.new
  t = SearchTerm.first(:term => u.entered_string)
  t = t.nil? ? SearchTerm.new(:term => u.entered_string) : t
  t.save
  
  print "Keywords:"
  u = UserInput.new
  created_terms = []
  u.entered_string.split(" ").each do |token|
    k = Keyword.first(:term => token)
    k = k.nil? ? Keyword.create(:term => token) : k
    KeywordAssociation.create(:search_term => t, :keyword => k)
    created_terms << token
  end
  puts "Added #{t.term}: #{created_terms.join(", ")}"
end

