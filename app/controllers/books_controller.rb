class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def create
    @book =Book.new(params[:book])
    
    if @book.save 
        redirect_to books_path 
    else
        render :action => "new"
    end
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find params[:id]
  end

  def search
  end

  def update
    #podrías llegar acá con
    #<%=link_to "read this book", [current_user, @book], :method=>"put"%>
    @user  = User.find params[:user_id]
    @book = Book.find params[:id]
    @user.read @book
    redirect_to @book
  end

  def destroy 
    #podrías llegar acá con
    #<%=link_to "forget this book", [current_user, @book], :method=>"delete"%>
    @user  = User.find params[:user_id]
    @book = Book.find params[:id]
    @user.forget @book
    redirect_to @book 
  end
end
