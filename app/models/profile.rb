class Profile < ActiveRecord::Base
  has_many :contacts
  has_many :groups
  has_many :reminders
end
