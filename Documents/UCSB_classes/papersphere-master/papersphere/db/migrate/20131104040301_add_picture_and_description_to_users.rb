class AddPictureAndDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :users, :description, :string
  end
end
