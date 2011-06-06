class CreateClientContracts < ActiveRecord::Migration
  def self.up
    create_table :client_contracts do |t|
      t.string :contract_code
      t.datetime :contract_date
      t.boolean :actual_contract
      t.integer :client_id
      t.string :status
      t.text :remark

      t.timestamps
    end
    ClientContract.create :contract_code => "CTD10000001A0", :contract_date => "02-Jan-2010", :actual_contract => "1", :client_id => "3", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000002A0", :contract_date => "08-Jan-2010", :actual_contract => "1", :client_id => "1", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000003A0", :contract_date => "15-Jan-2010", :actual_contract => "1", :client_id => "2", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000004A0", :contract_date => "01-Feb-2010", :actual_contract => "1", :client_id => "4", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000005A0", :contract_date => "13-Feb-2010", :actual_contract => "1", :client_id => "5", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000006A0", :contract_date => "04-Mar-2010", :actual_contract => "1", :client_id => "3", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000007A0", :contract_date => "20-Mar-2010", :actual_contract => "1", :client_id => "2", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000008A0", :contract_date => "05-Apr-2010", :actual_contract => "1", :client_id => "1", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000009A0", :contract_date => "20-Apr-2010", :actual_contract => "1", :client_id => "4", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000010A0", :contract_date => "01-May-2010", :actual_contract => "1", :client_id => "5", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000011A0", :contract_date => "01-Jun-2010", :actual_contract => "1", :client_id => "5", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000012A0", :contract_date => "10-May-2010", :actual_contract => "1", :client_id => "3", :status => "", :remark => ""
    ClientContract.create :contract_code => "CTD10000013A0", :contract_date => "31-May-2010", :actual_contract => "1", :client_id => "3", :status => "", :remark => ""
  end

  def self.down
    drop_table :client_contracts
  end
end
