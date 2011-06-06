class CreateClientContactRecords < ActiveRecord::Migration
  def self.up
    create_table :client_contact_records do |t|
      t.integer :product_id
      t.float :total1
      t.datetime :request_date
      t.integer :client_contract_id
      t.integer :status

      t.timestamps
    end
#    ContactRecord.create :product_id => "5", :total1 => "1000", :total2 => "0", :client_contract_id => "1", :status => "1"
#    ContactRecord.create :product_id => "2", :total1 => "2000", :total2 => "0", :client_contract_id => "2", :status => "1"
#    ContactRecord.create :product_id => "6", :total1 => "500", :total2 => "0", :client_contract_id => "3", :status => "1"
#    ContactRecord.create :product_id => "7", :total1 => "500", :total2 => "0", :client_contract_id => "3", :status => "1"
#    ContactRecord.create :product_id => "3", :total1 => "1000", :total2 => "0", :client_contract_id => "4", :status => "1"
#    ContactRecord.create :product_id => "4", :total1 => "500", :total2 => "0", :client_contract_id => "4", :status => "1"
#    ContactRecord.create :product_id => "1", :total1 => "3000", :total2 => "0", :client_contract_id => "5", :status => "1"
#    ContactRecord.create :product_id => "2", :total1 => "3000", :total2 => "0", :client_contract_id => "5", :status => "1"
#    ContactRecord.create :product_id => "3", :total1 => "4000", :total2 => "0", :client_contract_id => "6", :status => "1"
#    ContactRecord.create :product_id => "5", :total1 => "1000", :total2 => "0", :client_contract_id => "7", :status => "1"
#    ContactRecord.create :product_id => "8", :total1 => "1000", :total2 => "0", :client_contract_id => "7", :status => "1"
#    ContactRecord.create :product_id => "5", :total1 => "1500", :total2 => "0", :client_contract_id => "8", :status => "1"
#    ContactRecord.create :product_id => "3", :total1 => "500", :total2 => "0", :client_contract_id => "8", :status => "1"
#    ContactRecord.create :product_id => "6", :total1 => "3000", :total2 => "0", :client_contract_id => "9", :status => "1"
#    ContactRecord.create :product_id => "7", :total1 => "3000", :total2 => "0", :client_contract_id => "9", :status => "1"
#    ContactRecord.create :product_id => "4", :total1 => "3000", :total2 => "0", :client_contract_id => "10", :status => "1"
#    ContactRecord.create :product_id => "3", :total1 => "1000", :total2 => "0", :client_contract_id => "11", :status => "1"
#    ContactRecord.create :product_id => "5", :total1 => "2000", :total2 => "0", :client_contract_id => "12", :status => "1"
#    ContactRecord.create :product_id => "8", :total1 => "500", :total2 => "0", :client_contract_id => "13", :status => "1"
  end

  def self.down
    drop_table :client_contact_records
  end
end
