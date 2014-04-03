class RemoveTopicIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :topic_id, :integer
  end
end
