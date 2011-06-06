class CreateClientContainers < ActiveRecord::Migration
  def self.up
    create_table :client_containers do |t|
      t.string :container_code
      t.string :seal_code
      t.float :container_usage
      t.integer :client_shipment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :client_containers
  end
end
