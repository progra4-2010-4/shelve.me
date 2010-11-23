require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do 
    sign_in users :two
    @review = reviews :one
    @review.book = books :one
    @review.user = users :one

    @another_review = reviews :two
    @another_review.book = books :two
    @another_review.book.readers << users(:one) << users(:two)
    @another_review.user = users :two
    
    ActionMailer::Base.deliveries = []
  end


  test "should email when reviews are created, IFF there are readers" do 
    assert_difference("Review.count") do 
      post :create, :review=>@another_review.attributes, :book_id=>@another_review.book.id
    end
    assert_equal false, ActionMailer::Base.deliveries.empty?
  end

  test "should not email when reviews are created and no readers exist" do 
    assert_difference("Review.count") do 
      post :create, :review=>@review.attributes, :book_id=>@review.book.id
    end
    assert ActionMailer::Base.deliveries.empty?
  end
end
