class AddCoverColumnsToBook < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.string   :cover_file_name
      t.string   :cover_content_type
      t.integer  :cover_file_size
      t.datetime :cover_updated_at
    end
  end

  def self.down
    change_table :books do |t|
      t.remove :cover_file_name, :cover_file_size, :cover_content_type, :cover_updated_at
    end
  end
end
