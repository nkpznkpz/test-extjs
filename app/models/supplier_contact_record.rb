class SupplierContactRecord < ActiveRecord::Base
  belongs_to :supplier_contract
  belongs_to :product

  #validates_uniqueness_of :product_id, :scope => 'supplier_contract_id'

#  def self.find_name_for_select(supplier_contract_id)
#    find(:all, :include => [:product],
#      :conditions => ['supplier_contract_id=? and ', supplier_contract_id])
#  end
end
