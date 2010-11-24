class ReviewsMailer < ActionMailer::Base
  default :from => "from@example.com"

  def new_review_email(review)
    @book = review.book
    @review = review
    mail :to => @book.readers.collect{|r| r.email},
         :subject => "New review for #{@book.title}"
  end
end
