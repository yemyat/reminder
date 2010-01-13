class Reminder < ActiveRecord::Base
  belongs_to :profile
  has_many :contacts, :through=>:tagcontacts
  has_many :groups, :through=>:taggroups
  has_many :categories
end
