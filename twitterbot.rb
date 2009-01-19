require 'rubygems'
require 'twitter'
require 'dm-core'
require 'dm-validations'
require 'dm-solr-adapter'
require 'configatron'
require 'beanstalk-client'

require File.join(File.dirname(__FILE__), 'config', 'config')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'wine')
require File.join(File.dirname(__FILE__), 'lib','models', 'feed')
require File.join(File.dirname(__FILE__), 'lib', 'models','response')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'keyword')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'search_term')
require File.join(File.dirname(__FILE__), 'lib', 'models', 'keyword_association')
require File.join(File.dirname(__FILE__), 'lib', 'feed_parser')
require File.join(File.dirname(__FILE__), 'lib', 'generic_rss_feeder')
