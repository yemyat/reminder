class Contact < ActiveRecord::Base
  belongs_to :profile
  belongs_to :group
  has_many :reminders, :through=>:tagcontacts
end
