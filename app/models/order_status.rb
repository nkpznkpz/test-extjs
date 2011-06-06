class OrderStatus < ActiveRecord::Base
  has_many :client_order_fulfillments
  
  def self.find_name_for_select
    find(:all)
  end
end
