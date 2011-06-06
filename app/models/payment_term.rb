class PaymentTerm < ActiveRecord::Base
  has_many :client_pos
  validates_uniqueness_of :name
  validates_presence_of :name
end
