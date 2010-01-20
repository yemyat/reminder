# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100119150243) do

  create_table "categories", :force => true do |t|
    t.integer  "profile_id"
    t.string   "category_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "group_id"
    t.string   "firstName",   :limit => 45
    t.string   "lastName",    :limit => 45
    t.string   "mobilePhone", :limit => 50
    t.string   "email",       :limit => 50
    t.string   "note",        :limit => 600
    t.boolean  "gender"
    t.date     "dateOfBirth"
    t.boolean  "tagStatus",                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "profile_id"
    t.string   "title",       :limit => 45
    t.string   "description", :limit => 45
    t.boolean  "tagStatus",                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlies", :force => true do |t|
    t.integer  "reminder_id"
    t.date     "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "onetimes", :force => true do |t|
    t.integer  "reminder_id"
    t.date     "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "firstName",   :limit => 45
    t.string   "lastName",    :limit => 45
    t.string   "password"
    t.string   "mobilePhone", :limit => 50
    t.string   "email",       :limit => 50
    t.boolean  "gender"
    t.date     "dateOfBirth"
    t.string   "membership",  :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "category_id"
    t.string   "reminderTitle",   :limit => 45
    t.string   "reminderMessage", :limit => 200
    t.date     "reminderDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tagcontacts", :force => true do |t|
    t.integer  "reminder_id"
    t.integer  "profile_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggroups", :force => true do |t|
    t.integer  "reminder_id"
    t.integer  "profile_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yearlies", :force => true do |t|
    t.integer  "reminder_id"
    t.date     "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
