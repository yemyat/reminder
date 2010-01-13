class Tagcontact < ActiveRecord::Base
  belongs_to :contact
  belongs_to :reminder
end

