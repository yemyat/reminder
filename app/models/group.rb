class Group < ActiveRecord::Base
  belongs_to :profile
  has_many :contacts
  has_many :reminders, :through=>:taggroups
end
