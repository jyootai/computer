class AddTrashedToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :trashed, :boolean,default: false
  end
end
