class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :profile_id
      t.string :reminderTitle, :limit =>45
      t.string :reminderMessage, :limit => 200
      t.date :reminderDate
      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end

