class CreateBooksUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :books_users, :id=>false do |t|
      t.integer :book_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :books_users
  end
end
