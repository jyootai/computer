class AddTrashedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :trashed, :boolean,default: false
  end
end
