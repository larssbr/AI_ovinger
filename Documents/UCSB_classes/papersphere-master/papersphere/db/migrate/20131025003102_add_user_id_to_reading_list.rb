class AddUserIdToReadingList < ActiveRecord::Migration
  def change
    add_column :reading_lists, :user_id, :integer
  end
end
