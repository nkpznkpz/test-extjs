class SupplierContainer < ActiveRecord::Base
  has_many :supplier_order_groups
  belongs_to :supplier_shipment
end
