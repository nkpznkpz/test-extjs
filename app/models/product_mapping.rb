class ProductMapping < ActiveRecord::Base
  belongs_to :trader_sku
  belongs_to :supplier_sku
#  validates_uniqueness_of :scope => ''
end
