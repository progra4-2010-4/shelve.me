require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do 
    @book = books :one
    @new_book = Book.new(:title=>"Steppenwolf", :author=>"Herman Hesse")
    sign_in users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, :book => @new_book.attributes
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should get show" do
    get :show, :id => @book.to_param
    assert_response :success
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

end
