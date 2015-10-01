class AddIndexToForeignKeysOnReadingListPaper < ActiveRecord::Migration
  def change
    add_index :reading_list_papers, :paper_id
    add_index :reading_list_papers, :reading_list_id
  end
end
