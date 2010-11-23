require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do 
    @book = books :one
    @new_book = Book.new(:title=>"Steppenwolf", :author=>"Herman Hesse")
    @user = users :one
    sign_in users(:one)
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, :book => @new_book.attributes
    end

    assert_redirected_to books_path 
  end

  test "should get show" do
    get :show, :id => @book.to_param
    assert_response :success
    #debería traer a los usuarios que han leído el libro
    assert_not_nil assigns(:users)
  end

  test "should get search" do 
    get :search
    assert_response :success
  end

  test "should do search" do 
    get :search, :q=>books(:one).title.split[0]
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should be read" do 
    put :update, :user_id=>@user.id, :id => @book.id
    assert_redirected_to @book
    assert @user.has_read? @book
  end

  test "should be forgotten" do 
    @user.read @book
    assert_difference('@book.readers.count', -1) do 
      delete :destroy, :id=>@book.to_param, :user_id=>@user.to_param
    end 

    assert_equal false, @user.has_read?(@book)
  end

end
