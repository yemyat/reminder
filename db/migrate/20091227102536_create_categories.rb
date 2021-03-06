class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :profile_id
      t.string :category_title
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
