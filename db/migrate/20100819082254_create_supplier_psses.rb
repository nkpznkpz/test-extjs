class CreateSupplierPsses < ActiveRecord::Migration
  def self.up
    create_table :supplier_psses do |t|
      t.datetime :date_sent
      t.datetime :date_receive
      t.integer :pss_status_id
      t.integer :supplier_order_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_psses
  end
end
