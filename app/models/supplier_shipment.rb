class SupplierShipment < ActiveRecord::Base
  belongs_to :inco_term
  belongs_to :shipping_status
  belongs_to :supplier_container
end
