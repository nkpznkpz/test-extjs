class ClientInvoice < ActiveRecord::Base
  has_many :client_order_fulfillments
  has_many :client_invoice_rates
end
