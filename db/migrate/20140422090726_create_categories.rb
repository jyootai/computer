class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :topics_count, default: 0
      t.text :description

      t.timestamps
    end
  end
end
