class AddIndexToAuthorIdForComments < ActiveRecord::Migration
  def change
    add_index :comments, :author_id
  end
end
