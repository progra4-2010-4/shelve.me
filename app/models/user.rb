class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :reviews

  has_and_belongs_to_many :books

  def read(book) 
    self.books << book
    #equivale a 
    #book.readers << self
  end

  def forget(book)
    self.books.delete book
    #equivale a 
    #book.readers.delete self
  end

  def has_read?(book)
    book.readers.exists? self
  end
end
