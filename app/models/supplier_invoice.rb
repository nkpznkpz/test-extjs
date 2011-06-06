class SupplierInvoice < ActiveRecord::Base
  has_many :supplier_invoice_rates
  has_many :supplier_order_fulfillments
end
