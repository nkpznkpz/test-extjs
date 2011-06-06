class SupplierSku < ActiveRecord::Base
  has_many :supplier_orders
  belongs_to :supplier
  has_many :product_mappings
  has_many :trader_skus, :through => :product_mappings
  has_many :client_order_fulfillments
  validates_uniqueness_of :sku, :scope => 'supplier_id'
  validates_presence_of :sku, :supplier_id
  def self.find_name_for_select
    find(:all)
  end
  
  def before_destroy
    if supplier_orders.count != 0
      return false
    else
      return true
    end
  end
end
