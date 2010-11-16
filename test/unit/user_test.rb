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

  test "books are added" do 
    
    user= User.create! :username=>"salinger", :email=>"not@jdsalinger.com", :password=>"holden" 
    u = books(:one)
    v = books(:two)
    #esta es una asociación has_and_belongs_to_many:
    #cómo declararla: http://guides.rubyonrails.org/association_basics.html#the-has_and_belongs_to_many-association
    #cómo cambiar el nombre de la relación: http://guides.rubyonrails.org/association_basics.html#has_and_belongs_to_many-class_name
    #cómo aplicarla a la base de datos: http://guides.rubyonrails.org/association_basics.html#creating-join-tables-for-has_and_belongs_to_many-associations
    #cómo usarla: http://guides.rubyonrails.org/association_basics.html#has_and_belongs_to_many-association-reference
    
    assert_difference("user.books.count", 2) do
      user.books << u
      user.books << v
    end

    assert user.books.exists? :title => u.title, :author=> u.author
    assert user.books.exists? :title => v.title, :author=> v.author
  end

  test "books are deleted" do 
    user= User.create! :username => "ecioran", :email=>"rumanian@crazies.com", :password=>"demiurgo" 
    
    assert_difference("user.books.count") do
      user.books << books(:one)
    end

    assert_difference("user.books.count", -1) do 
      user.books.delete books(:one)
    end
    
  end
end
