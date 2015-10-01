class CreateReadingListShares < ActiveRecord::Migration
  def change
    create_table :reading_list_shares do |t|
      t.integer :group_id
      t.integer :reading_list_id
      t.string :access_rights

      t.timestamps
    end
  end
end
