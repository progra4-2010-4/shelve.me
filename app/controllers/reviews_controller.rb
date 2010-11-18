class ReviewsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @book = Book.find params[:book_id]
    @review = Review.new
    @review.book = @book
    @review.user = current_user
    #redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @book = Book.find params[:book_id]
    @review = Review.new params[:review]
    @review.user = current_user
    if @review.save
      redirect_to book_review_path(@book, @review)
    else
      render :new
    end
  end

  def edit
    @review = current_user.reviews.find params[:id]
    #@book = Book.find params[:book_id]
    #no necesitamos re-encontrar @book porque ya lo podemos obtener con @review.book
    @book = @review.book
  end

  def update
    #un usuario sólo debería editar sus PROPIAS reviews
    #si pusieramos : @review = Review.find params[:id]
    #¡podríamos editar las de otros! (pruébenlo=
    @review = current_user.reviews.find params[:id]
    @book = @review.book
    if @review.update_attributes params[:review]
      redirect_to book_review_path(@book, @review)
    else
      #esta view necesita la instance
      render :edit
    end
  end

  def destroy
  end

end
