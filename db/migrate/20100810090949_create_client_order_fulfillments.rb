class CreateClientOrderFulfillments < ActiveRecord::Migration
  def self.up
    create_table :client_order_fulfillments do |t|
      t.integer :client_invoice_id
      t.integer :order_status_id
      t.integer :supplier_sku_id
      t.float :total_drain_weight
      t.float :total_gross_weight
      t.float :total_net_weight
      t.float :quantity
      t.float :container_usage
      t.integer :unit_id
      t.integer :client_order_id
      t.integer :supplier_order_fulfillment_id
      t.timestamps
    end
    #    ClientOrderFulfillment.create :client_invoice_id => "1", :order_status_id => "1", :supplier_sku_id => "6", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "1"
    #    ClientOrderFulfillment.create :client_invoice_id => "2", :order_status_id => "1", :supplier_sku_id => "2", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "2"
    #    ClientOrderFulfillment.create :client_invoice_id => "3", :order_status_id => "1", :supplier_sku_id => "2", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "2"
    #    ClientOrderFulfillment.create :client_invoice_id => "4", :order_status_id => "1", :supplier_sku_id => "7", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "500", :container_usage => "0", :unit_id => "1", :client_order_id => "3"
    #    ClientOrderFulfillment.create :client_invoice_id => "4", :order_status_id => "1", :supplier_sku_id => "8", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "500", :container_usage => "0", :unit_id => "1", :client_order_id => "4"
    #    ClientOrderFulfillment.create :client_invoice_id => "5", :order_status_id => "1", :supplier_sku_id => "4", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "5"
    #    ClientOrderFulfillment.create :client_invoice_id => "6", :order_status_id => "1", :supplier_sku_id => "5", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "500", :container_usage => "0", :unit_id => "1", :client_order_id => "6"
    #    ClientOrderFulfillment.create :client_invoice_id => "7", :order_status_id => "1", :supplier_sku_id => "1", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "7"
    #    ClientOrderFulfillment.create :client_invoice_id => "7", :order_status_id => "1", :supplier_sku_id => "2", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "8"
    #    ClientOrderFulfillment.create :client_invoice_id => "8", :order_status_id => "1", :supplier_sku_id => "1", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "7"
    #    ClientOrderFulfillment.create :client_invoice_id => "8", :order_status_id => "1", :supplier_sku_id => "2", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "8"
    #    ClientOrderFulfillment.create :client_invoice_id => "9", :order_status_id => "1", :supplier_sku_id => "3", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "2000", :container_usage => "0", :unit_id => "1", :client_order_id => "9"
    #    ClientOrderFulfillment.create :client_invoice_id => "10", :order_status_id => "1", :supplier_sku_id => "3", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "2000", :container_usage => "0", :unit_id => "1", :client_order_id => "10"
    #    ClientOrderFulfillment.create :client_invoice_id => "11", :order_status_id => "1", :supplier_sku_id => "6", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "11"
    #    ClientOrderFulfillment.create :client_invoice_id => "11", :order_status_id => "1", :supplier_sku_id => "9", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "12"
    #    ClientOrderFulfillment.create :client_invoice_id => "12", :order_status_id => "1", :supplier_sku_id => "10", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "13"
    #    ClientOrderFulfillment.create :client_invoice_id => "13", :order_status_id => "1", :supplier_sku_id => "3", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "500", :container_usage => "0", :unit_id => "1", :client_order_id => "14"
    #    ClientOrderFulfillment.create :client_invoice_id => "14", :order_status_id => "1", :supplier_sku_id => "7", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "15"
    #    ClientOrderFulfillment.create :client_invoice_id => "14", :order_status_id => "1", :supplier_sku_id => "8", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "16"
    #    ClientOrderFulfillment.create :client_invoice_id => "15", :order_status_id => "1", :supplier_sku_id => "7", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "15"
    #    ClientOrderFulfillment.create :client_invoice_id => "15", :order_status_id => "1", :supplier_sku_id => "8", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1500", :container_usage => "0", :unit_id => "1", :client_order_id => "16"
    #    ClientOrderFulfillment.create :client_invoice_id => "16", :order_status_id => "1", :supplier_sku_id => "5", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "3000", :container_usage => "0", :unit_id => "1", :client_order_id => "17"
    #    ClientOrderFulfillment.create :client_invoice_id => "17", :order_status_id => "1", :supplier_sku_id => "3", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "1000", :container_usage => "0", :unit_id => "1", :client_order_id => "18"
    #    ClientOrderFulfillment.create :client_invoice_id => "18", :order_status_id => "1", :supplier_sku_id => "6", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "2000", :container_usage => "0", :unit_id => "1", :client_order_id => "19"
    #    ClientOrderFulfillment.create :client_invoice_id => "18", :order_status_id => "1", :supplier_sku_id => "9", :total_drain_weight => "0", :total_gross_weight => "0", :total_net_weight => "0", :quantity => "500", :container_usage => "0", :unit_id => "1", :client_order_id => "20"
  end

  def self.down
    drop_table :client_order_fulfillments
  end
end
