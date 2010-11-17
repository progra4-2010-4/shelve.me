class Book < ActiveRecord::Base
 attr_accessible :title, :author, :description

 validates_presence_of :title
end
