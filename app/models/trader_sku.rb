class TraderSku < ActiveRecord::Base
  belongs_to :product
  has_many :client_orders
  has_many :product_mappings
  has_many :supplier_order_fulfillments
  has_many :supplier_skus, :through => :product_mappings
  validates_uniqueness_of :sku
  validates_presence_of :sku
  def self.find_name_for_select
    find(:all)
  end

  def self.find_trader_sku_ccr_select(client_contract_id)

    find(:all, :joins => [:client_contact_records],
      :conditions => ['client_contact_records.id=?', client_contract_id])
  end
  
  def before_destroy
    if client_orders.count != 0
     return false
    else
     return true
    end
  end
end
