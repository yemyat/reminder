class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :profile_id
      t.integer :group_id
      t.string :firstName, :limit=>45
      t.string :lastName, :limit=>45
      t.string :mobilePhone, :limit => 50
      t.string :email, :limit => 50
      t.string :note,:limit=>600
      t.boolean :gender
      t.date :dateOfBirth
      t.boolean :tagStatus, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
