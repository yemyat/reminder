class Category < ActiveRecord::Base
  has_many :reminders
  belongs_to :profile
end
