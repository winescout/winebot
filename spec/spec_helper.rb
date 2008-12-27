require "rubygems"
require 'spec'
require File.join(File.dirname(__FILE__), '..', 'winebot.rb')

DataMapper.setup(:default, "mysql:///winebot")
DataMapper.setup(:search, 'sphinx://localhost:3312')
