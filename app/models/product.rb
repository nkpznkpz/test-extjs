class Product < ActiveRecord::Base
  has_many :trader_skus
  has_many :supplier_skus
  validates_uniqueness_of :name
  has_many :client_contact_records
  has_many :supplier_contact_records
  # TODO: palakon - need to add product_type model
  validates_presence_of :name, :product_type, :detail
  
  def self.find_name_for_select(product_name)
    find(:all) do
      name =~ "#{product_name}%" if product_name != ''
    end
  end
  def before_destroy
    if trader_skus.count != 0
      return false
    else
      return true
    end
  end
end
