class CreateTaggroups < ActiveRecord::Migration
  def self.up
    create_table :taggroups do |t|
      t.integer :reminder_id
      t.integer :profile_id
      t.integer :group_id
      t.timestamps
    end
  end

  def self.down
    drop_table :taggroups
  end
end
