class CreateSupplierOrderGroups < ActiveRecord::Migration
  def self.up
    create_table :supplier_order_groups do |t|
      t.integer :supplier_order_fulfillment_id
      t.integer :supplier_container_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_order_groups
  end
end
