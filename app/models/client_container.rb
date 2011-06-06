class ClientContainer < ActiveRecord::Base
  has_many :client_order_groups
  belongs_to :client_shipment
end
