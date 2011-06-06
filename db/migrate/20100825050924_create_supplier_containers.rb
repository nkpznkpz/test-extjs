class CreateSupplierContainers < ActiveRecord::Migration
  def self.up
    create_table :supplier_containers do |t|
      t.string :container_code
      t.string :seal_code
      t.float :container_usage
      t.integer :supplier_shipment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_containers
  end
end
