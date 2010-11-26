require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books :one
    @book.cover = File.new Rails.root + "test/fixtures/images/rails.png"
    @realbook = Book.create(:author=>"Ayn Rand", :title=>"The Fountainhead")
  end
  
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

  test "readers are added" do 
    book = Book.create! :title=>"The Catcher in the Rye", :author=>"J.D. Salinger"
    u = users(:one)
    v = users(:two)
    #esta es una asociación has_and_belongs_to_many:
    #cómo declararla: http://guides.rubyonrails.org/association_basics.html#the-has_and_belongs_to_many-association
    #cómo cambiar el nombre de la relación: http://guides.rubyonrails.org/association_basics.html#has_and_belongs_to_many-class_name
    #cómo aplicarla a la base de datos: http://guides.rubyonrails.org/association_basics.html#creating-join-tables-for-has_and_belongs_to_many-associations
    #cómo usarla: http://guides.rubyonrails.org/association_basics.html#has_and_belongs_to_many-association-reference
    
    assert_difference("book.readers.count", 2) do
      book.readers << u
      book.readers << v
    end

    assert book.readers.exists? :username => u.username 
    assert book.readers.exists? :username => v.username 
  end

  test "readers are deleted" do 
    book = Book.create! :title => "El aciago demiurgo", :author=>"Émile Michel Cioran"
    
    assert_difference("book.readers.count") do
      book.readers << users(:one)
    end

    assert_difference("book.readers.count", -1) do 
      book.readers.delete users(:one)
    end
    
  end

  test "has attachment field" do 
    assert @book.respond_to? :cover
    assert_equal "rails.png", @book.cover.original_filename
    #le quitamos el querystring
    assert_match "/system/covers/#{@book.id}/original/rails.png", @book.cover.url.split('?')[0]
    #más métodos: @book.cover.methods.sort
  end

  test "has twitter feed" do 
    assert @realbook.respond_to? :mentions_in
    assert_not_nil @realbook.mentions_in :twitter
    assert_kind_of SocialFeed::Entry, @realbook.mentions_in(:twitter).first
  end
  
  test "has facebook feed" do 
    assert @realbook.respond_to? :mentions_in
    assert_not_nil @realbook.mentions_in :facebook
    assert_kind_of SocialFeed::Entry, @realbook.mentions_in(:facebook).first
  end

end
