class AddPaperCodeToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :paper_code, :string
    add_index :papers, :paper_code, :unique => true
  end
end
