require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  test "review is saved" do 
    r = Review.new(:quality=>"bad", :book=>books(:one), :user=>users(:one), :review => "*"*400)

    assert r.save
  end

  test "review is not empty" do
    r = Review.new(:quality=>"bad", :book=>books(:one), :user=>users(:one))

    assert_equal false, r.save
    assert_equal 1, r.errors.size
    assert r.errors[:review].any?

  end
  
  test "review is less than 400 characters" do 
    r = Review.new(:quality=>"bad", :book=>books(:one), :user=>users(:one), :review => "*"*401)

    assert_equal false, r.save
    assert_equal 1, r.errors.size
    assert r.errors[:review].any?
  end

  test "when quality is empty, defaults to a constant" do
    r = Review.new(:review=>"meh", :book=>books(:one), :user=>users(:one))
    
    assert r.save
    assert_equal  Review::DEFAULT_QUALITY, r.quality
  end

end
