class ClientOrderGroup < ActiveRecord::Base
  belongs_to :client_order_fulfillment
  belongs_to :client_container
end
