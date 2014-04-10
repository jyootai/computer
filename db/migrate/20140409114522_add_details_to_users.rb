class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :avatar, :string
    add_column :users, :professional, :string
    add_column :users, :sex, :string
  end
end
