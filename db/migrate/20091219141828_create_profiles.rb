class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :firstName, :limit=>45
      t.string :lastName, :limit=>45
      t.string :password
      t.string :mobilePhone, :limit => 50
      t.string :email, :limit => 50
      t.boolean :gender
      t.date :dateOfBirth
      t.string :membership,:limit=>45
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
