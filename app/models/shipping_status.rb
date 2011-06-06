class ShippingStatus < ActiveRecord::Base
  has_many :supplier_shipments
  has_many :client_shipments

  def self.find_name_for_select
    find(:all)
  end
end
