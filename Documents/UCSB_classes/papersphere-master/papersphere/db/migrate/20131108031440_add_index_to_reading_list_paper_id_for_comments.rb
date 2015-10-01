class AddIndexToReadingListPaperIdForComments < ActiveRecord::Migration
  def change
    add_index :comments, :reading_list_paper_id
  end
end
