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
  end

  def search
  end

end
