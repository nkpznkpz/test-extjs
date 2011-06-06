class CreateSupplierContactRecords < ActiveRecord::Migration
  def self.up
    create_table :supplier_contact_records do |t|
      t.integer :product_id
      t.float :total1
      t.datetime :request_date
      t.integer :supplier_contract_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_contact_records
  end
end
