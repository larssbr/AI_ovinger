class AddMailsettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :added_to_group, :boolean, :default => true
    add_column :users, :list_shared, :boolean, :default => true
    add_column :users, :comment_added, :boolean, :default => true
    add_column :users, :paper_added, :boolean, :default => true
  end
end
