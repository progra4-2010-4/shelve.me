class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.text :review
      t.string :quality

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
