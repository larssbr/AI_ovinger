class CreateReadingListPapers < ActiveRecord::Migration
  def change
    drop_table :papers_reading_lists
    create_table :reading_list_papers do |t|
      t.integer :reading_list_id
      t.integer :paper_id

      t.timestamps
    end
  end
end
