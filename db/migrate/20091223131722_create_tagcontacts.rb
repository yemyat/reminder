class CreateTagcontacts < ActiveRecord::Migration
  def self.up
    create_table :tagcontacts do |t|
      t.integer :reminder_id
      t.integer :profile_id
      t.integer :contact_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tagcontacts
  end
end
