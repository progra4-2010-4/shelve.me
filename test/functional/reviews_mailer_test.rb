require 'test_helper'

class ReviewsMailerTest < ActionMailer::TestCase
  setup do 
    @book = books :one
    @book.readers << users(:one) << users(:two)
    @review = reviews :one
    @review.user = users :two
    @review.book = @book
  end    

  test "An email is sent to a book subscribers" do
    assert ReviewsMailer.respond_to? :new_review_email
    email = ReviewsMailer.new_review_email(@review).deliver

    assert_equal false, ActionMailer::Base.deliveries.empty?
    assert_equal @book.readers.collect{|r| r.email}, email.to
    assert_equal "New review for #{@book.title}", email.subject
    assert_match /by #{@review.user.username}/, email.encoded
    assert_match /#{@review.review}/, email.encoded
  end
end
