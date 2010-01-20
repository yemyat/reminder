class CreateMonthlies < ActiveRecord::Migration
  def self.up
    create_table :monthlies do |t|
      t.integer :reminder_id
      t.date :delivery_date
      t.timestamps
    end
  end

  def self.down
    drop_table :monthlies
  end
end
