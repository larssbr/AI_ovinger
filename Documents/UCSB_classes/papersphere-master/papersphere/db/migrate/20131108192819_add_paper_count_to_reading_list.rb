class AddPaperCountToReadingList < ActiveRecord::Migration
  def change
    add_column :reading_lists, :paper_count, :integer, :default => 0
  end
end
