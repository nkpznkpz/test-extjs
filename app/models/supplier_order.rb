class SupplierOrder < ActiveRecord::Base
  belongs_to :supplier_sku
  belongs_to :supplier_po
  has_many :supplier_order_fulfillments, :dependent => :destroy

  validates_numericality_of :total_quantity
  validates_numericality_of :unit_price

  def validate_on_update
    client_order_ff_count = ClientOrderFulfillment.count(:all,
      :conditions => ['supplier_order_fulfillment_id=?',supplier_order_fulfillments[0].id])
    if client_order_ff_count == 0
      return true
    else
      errors.add_to_base('Can not edit, supplier order is fulfilled.')
      return false
    end
  end

  def before_destroy
    client_order_ff_count = ClientOrderFulfillment.count(:all,
      :conditions => ['supplier_order_fulfillment_id=?',supplier_order_fulfillments[0].id])
    if client_order_ff_count == 0
      return true
    else
      return false
    end
  end
end
