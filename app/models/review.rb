class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :review
  validates_length_of :review, :maximum => 400

  before_save :default_quality
  
  QUALITY_OPTIONS = ["Bad", "Regular", "Good"]
  DEFAULT_QUALITY = QUALITY_OPTIONS[1]
  def default_quality 
    self.quality = DEFAULT_QUALITY if self.quality.blank? 
  end
end
