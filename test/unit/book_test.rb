require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "book gets created" do 
    b = Book.new(:author=>"E.A. Poe", :title=>"The imp of the perverse", :description=>"essay on the human condition")
    assert b.save

    c = Book.new(:author=>"Gaahl", :title=>"Gaahlism")
    assert c.save
  end

  test "title can't be empty" do 
    b = Book.new(:author=>"E.A. Poe")
    assert ! b.save
    assert b.errors[:title].any? #any errors on title?
    assert_equal 1, b.errors.size #only title should fail
  end

  test "author can't be empty" do
    b = Book.new(:title=>"Ligeia")
    assert ! b.save
    assert b.errors[:author].any? #any errors on author?
    assert_equal 1, b.errors.size #only author should fail
  end

  test "description can be empty" do
    b = Book.new(:title=>"les fleurs du mal", :author=>"Charles Baudelaire")
    assert b.save
  end
  
  test "author is capitalized" do 
    b = Book.new(:title=>"another book", :author=>"ARtHuR C. ClARkE")
    assert b.save
    assert_equal "Arthur C. Clarke", b.author
  end

  test "author is stored with stripped space" do 
    b = Book.new :title=>"The Gods Themselves", :author=>"Arthur C.    Clarke   "
    assert b.save
    assert_equal "Arthur C. Clarke", b.author
  end

  test "title is capitalized" do 
    b = Book.new :title=>"2001: A SpAcE OdYsSeY", :author=>"Arthur C. Clarke"
    assert b.save
    assert_equal "2001: A Space Odyssey", b.title
  end

  test "title is stored with extra space stripped" do
    title = "  The     life  and  times of    James Taggart  "
    b = Book.new(:title=>title, :author=>"Dagny Taggart")
    
    assert b.save
    assert_equal "The Life And Times Of James Taggart", b.title
  end

  test "title and author can't be duplicated" do 
    a = books :one
    #a completely duplicated book is not allowed
    #cf: http://siddharthdawara.blogspot.com/2008/09/rails-beforesave-and-validations.html
    b = Book.new(:title=>a.title, :author=>a.author)
    assert_equal false, b.save 
    assert b.errors[:title].any?
    
    #validation MUST be case insensitive
    c = Book.new(:title=>a.title.upcase, :author=>a.author)
    
    assert_equal false, c.valid?
    assert c.errors[:title].any?

    #a book with a different author should be allowed
    d = Book.new(:title=>a.title, :author=>"Another author")

    assert d.save
    
    #slightly different books that are, nevertheless, equal, shouldn't be allowed
    e = Book.create!(:title => "I, Robot", :author=>"Isaac Asimov")
    f = Book.new :title=>"I,   ROBOT", :author=>"iSAaC    aSImOV"

    assert_equal false, f.valid?
  end

end
