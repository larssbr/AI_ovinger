class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.string :author
      t.integer :year
      t.string :publication
      t.string :url

      t.timestamps
    end
  end
end
