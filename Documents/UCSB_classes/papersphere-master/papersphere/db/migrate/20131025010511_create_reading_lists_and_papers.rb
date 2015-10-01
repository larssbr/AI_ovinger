class CreateReadingListsAndPapers < ActiveRecord::Migration
  def change
    create_table :papers_reading_lists do |t|
      t.belongs_to :reading_list
      t.belongs_to :paper
    end
  end
end
