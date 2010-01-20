class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :profile_id
      t.string :title, :limit => 45
      t.string :description, :limit => 45
      t.boolean :tagStatus, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
