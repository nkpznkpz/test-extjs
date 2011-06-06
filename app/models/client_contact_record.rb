class ClientContactRecord < ActiveRecord::Base
  belongs_to :client_contract
  belongs_to :product
  has_many :trader_skus, :through => :product

  attr_accessor :product_name
  #validates_uniqueness_of :product_id, :scope => 'client_contract_id'
#  def before_destroy
#
#
#  end

  def self.find_name_for_select(client_contract_id)
    find(:all, :include => [:product, :trader_skus],
      :conditions => ['client_contract_id=?', client_contract_id])
  end
  
end
