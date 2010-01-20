class Reminder < ActiveRecord::Base
  belongs_to :profile
  belongs_to :category
  has_many :contacts, :through=>:tagcontacts
  has_many :groups, :through=>:taggroups
  has_many :yearlies
  has_many :monthlies
  has_many :onetimes
end
