class CreateGroupMembers < ActiveRecord::Migration
  def change
    drop_table :groups_users
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
