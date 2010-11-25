require 'json'
require 'open-uri'
require 'cgi'
module SocialFeed 
  class Entry 
    attr_accessor :who, :what 
    def initialize(who, what ) 
      @who, @what, @where = who, what 
    end
  end

  class Site 
    def self.create_search_by(criteria, symbol) 
      (class << self; self; end).instance_eval do
        define_method("search_by_#{criteria.to_s}") do |query|
          search(symbol+query)
        end
      end
    end
  end

  class Twitter < Site
    def self.search(query) 
      data = open "http://search.twitter.com/search.json?q=#{CGI.escape(query)}"
      parsed = JSON.parse data.read
      parsed['results'].collect do |t| 
        Entry.new t['from_user'], t['text']
      end
    end

    create_search_by :hashtag, '#'
    create_search_by :mention, '@'
    create_search_by :from, 'from:'
  end

  class Facebook < Site
    def self.search(query) 
      data = open "https://graph.facebook.com/search?q=#{CGI.escape(query)}&type=post"
      parsed = JSON.parse data.read
      parsed['data'].collect do |t| 
        Entry.new t['from']['name'], t['message']
      end
    end
  end
  
  def self.method_missing(name, *args) 
    #obtener una constante:
    info = name.to_s.scan(/search_in_(\w+)/).flatten
    unless info.empty?
      self.const_get(info[0].capitalize).send :search, *args
    end
  end
end
