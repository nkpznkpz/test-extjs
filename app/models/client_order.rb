class ClientOrder < ActiveRecord::Base
  belongs_to :trader_sku
  belongs_to :client_po
  has_many :client_order_fulfillments

  validates_numericality_of :total_quantity
  validates_numericality_of :unit_price

#  def validate_on_create
#
#  end
#
#  def validate_on_update
#
#  end
  
  def before_destroy
    if client_order_fulfillments.count != 0
      return false
    else
      return true
    end
  end 
end
