ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fakeweb'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  FakeWeb.register_uri(:get, "http://search.twitter.com/search.json?q=the+fountainhead", 
                       :body=>File.read(File.join(Rails.root, "test", "fixtures", "fakeweb", "twitter.json"))) 
  FakeWeb.register_uri(:get, "https://graph.facebook.com/search?q=the+fountainhead&type=post",
                       :body=>File.read(File.join(Rails.root, "test", "fixtures", "fakeweb", "facebook.json")))
end
