class CreateClientOrderGroups < ActiveRecord::Migration
  def self.up
    create_table :client_order_groups do |t|
      t.integer :client_order_fulfillment_id
      t.integer :client_container_id

      t.timestamps
    end
  end

  def self.down
    drop_table :client_order_groups
  end
end
