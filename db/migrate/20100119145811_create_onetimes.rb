class CreateOnetimes < ActiveRecord::Migration
  def self.up
    create_table :onetimes do |t|
        t.integer :reminder_id
      t.date :delivery_date
      t.timestamps
    end
  end

  def self.down
    drop_table :onetimes
  end
end
