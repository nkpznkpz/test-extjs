class SupplierOrderFulfillment < ActiveRecord::Base
  belongs_to :supplier_order
  belongs_to :unit
  belongs_to :order_status
  belongs_to :supplier_invoice
  belongs_to :trader_sku
  has_many :supplier_order_groups
  has_many :client_order_fulfillments
#  def validate_on_create
#    quantity_count = SupplierOrderFulfillment.sum(:quantity,
#      :conditions => ['supplier_order_id=?',supplier_order_id])
#    #total quantity in order >= all quantity in fulfillment
#    puts quantity_count
#    if  supplier_order.total_quantity >= quantity_count + quantity
#      return true
#    else
#      errors.add_to_base('total quantity < fulfillment quantity')
#      return false
#    end
#  end

  def validate_on_update
    quantity_count = SupplierOrderFulfillment.sum(:quantity,
      :conditions => ['supplier_order_id=?',supplier_order_id])
    #total quantity in order >= all quantity in fulfillment
    current_quantity = SupplierOrderFulfillment.find(id).quantity
    puts quantity_count
    if  supplier_order.total_quantity >= quantity_count + quantity - current_quantity
      return true
    else
      errors.add_to_base('total quantity < fulfillment quantity')
      return false
    end
  end
end
