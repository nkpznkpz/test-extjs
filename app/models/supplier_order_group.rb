class SupplierOrderGroup < ActiveRecord::Base
  belongs_to :supplier_order_fulfillment
  belongs_to :supplier_container
end
