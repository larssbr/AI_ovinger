class AddIndexToReadingListPaperIdForRatings < ActiveRecord::Migration
  def change
    add_index :ratings, :reading_list_paper_id
  end
end
