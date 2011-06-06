class ClientShipment < ActiveRecord::Base
  belongs_to :inco_term
  belongs_to :shipping_status
  has_many :client_containers
end
