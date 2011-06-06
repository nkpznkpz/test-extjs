class ClientOrderFulfillment < ActiveRecord::Base
  belongs_to :client_order
  belongs_to :unit
  belongs_to :order_status
  belongs_to :client_invoice
  belongs_to :supplier_sku
  has_many :client_order_groups
  belongs_to :supplier_order_fulfillment
  
  def validate_on_create
    quantity_sum = ClientOrderFulfillment.sum(:quantity,
      :conditions => ['client_order_id=?',client_order_id])
    #total quantity in order >= all quantity in fulfillment
    if  client_order.total_quantity >= quantity_sum + quantity
      return true
    else
      errors.add_to_base('total quantity < fulfillment quantity')
      return false
    end
  end

  def validate_on_update
    quantity_sum = ClientOrderFulfillment.sum(:quantity,
      :conditions => ['client_order_id=?',client_order_id])
    #total quantity in order >= all quantity in fulfillment
    current_quantity = ClientOrderFulfillment.find(id).quantity
    if  client_order.total_quantity >= quantity_sum + quantity - current_quantity
      return true
    else
      errors.add_to_base('total quantity < fulfillment quantity')
      return false
    end
  end  
end
