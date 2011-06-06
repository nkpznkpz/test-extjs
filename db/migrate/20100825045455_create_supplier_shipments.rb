class CreateSupplierShipments < ActiveRecord::Migration
  def self.up
    create_table :supplier_shipments do |t|
      t.string :shipment_code
      t.string :departure_gmt
      t.string :departure_port
      t.datetime :actual_etd
      t.datetime :actual_eta
      t.string :arrival_gmt
      t.string :destination_port
      t.integer :transit
      t.string :place_of_delivery
      t.datetime :docs_sent_date
      t.string :vessel
      t.string :remark
      t.string :destination_charge
      t.integer :inco_term_id
      t.integer :shipping_status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_shipments
  end
end
