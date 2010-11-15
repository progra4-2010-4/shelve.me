require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "a user is created with username, email and password" do 
    u = User.new :username => "foobar",
                 :email    => "bar@foo.com",
                 :password => "barfoo"

    assert u.save
  end

  test "a username can't be empty" do
    u = User.new :username => "",
                 :email    => "foo@bar.com",
                 :password => "barfoo"

    assert !u.save
    assert u.errors[:username].any?
    assert_equal 1, u.errors.size
  end

  test "a username must be unique" do 
    uname = "johndoe"
    u1 = User.new :username=>uname, :email=>"mail@net.com", :password=>"bazbar"

    assert u1.save

    u2 = User.new :username=>uname, :email=>"net@mail.com", :password=>"supersecret"
    
    assert !u2.save
    assert_equal 1, u2.errors.size
    assert u2.errors[:username].any?

  end
end
