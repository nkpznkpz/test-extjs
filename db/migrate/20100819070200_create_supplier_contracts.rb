class CreateSupplierContracts < ActiveRecord::Migration
  def self.up
    create_table :supplier_contracts do |t|
      t.string :contract_code
      t.datetime :contract_date
      t.boolean :actual_contract
      t.integer :supplier_id
      t.string :status
      t.text :remark
      
      t.timestamps
    end
    SupplierContract.create :contract_code => "STD100000001A0", :contract_date => "02-Jan-2010", :actual_contract => "1", :supplier_id => "4", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000002A0", :contract_date => "08-Jan-2010", :actual_contract => "1", :supplier_id => "3", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000003A0", :contract_date => "15-Jan-2010", :actual_contract => "1", :supplier_id => "5", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000004A0", :contract_date => "01-Feb-2010", :actual_contract => "1", :supplier_id => "2", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000005A0", :contract_date => "13-Feb-2010", :actual_contract => "1", :supplier_id => "3", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000006A0", :contract_date => "04-Mar-2010", :actual_contract => "1", :supplier_id => "1", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000007A0", :contract_date => "20-Mar-2010", :actual_contract => "1", :supplier_id => "4", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000008A0", :contract_date => "05-Apr-2010", :actual_contract => "1", :supplier_id => "1", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000009A0", :contract_date => "20-Apr-2010", :actual_contract => "1", :supplier_id => "5", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000010A0", :contract_date => "01-May-2010", :actual_contract => "1", :supplier_id => "2", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000011A0", :contract_date => "01-Jun-2010", :actual_contract => "1", :supplier_id => "2", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000012A0", :contract_date => "10-May-2010", :actual_contract => "1", :supplier_id => "4", :status => "", :remark => ""
    SupplierContract.create :contract_code => "STD100000013A0", :contract_date => "31-May-2010", :actual_contract => "1", :supplier_id => "4", :status => "", :remark => ""
  end

  def self.down
    drop_table :supplier_contracts
  end
end
