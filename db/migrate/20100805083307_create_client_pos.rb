class CreateClientPos < ActiveRecord::Migration
  def self.up
    create_table :client_pos do |t|
      t.string :po
      t.datetime :po_date
      t.float :po_amount
      t.string :currency
      t.integer :client_contract_id
      t.integer :payment_term_id
      t.integer :payment_term_day
      t.string :status
      t.text :remark

      t.timestamps
    end
#    ClientPo.create :po => "GN5301/01", :po_date => "02-Jan-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "1", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "NV5301/01", :po_date => "08-Jan-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "2", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "WF5301/01", :po_date => "15-Jan-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "3", :payment_term_id => "1", :payment_term_day => "45", :status => "", :remark => ""
#    ClientPo.create :po => "JE5302/01", :po_date => "01-Feb-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "4", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "TN5302/01", :po_date => "13-Feb-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "5", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "GN5303/01", :po_date => "04-Mar-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "6", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "GN5303/02", :po_date => "04-Mar-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "6", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "WF5303/01", :po_date => "20-Mar-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "7", :payment_term_id => "1", :payment_term_day => "45", :status => "", :remark => ""
#    ClientPo.create :po => "WF5303/02", :po_date => "20-Mar-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "7", :payment_term_id => "1", :payment_term_day => "45", :status => "", :remark => ""
#    ClientPo.create :po => "NV5304/01", :po_date => "05-Apr-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "8", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "NV5304/02", :po_date => "05-Apr-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "8", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "JE5304/01", :po_date => "20-Apr-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "9", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "JE5304/02", :po_date => "20-Apr-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "9", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "TN5305/01", :po_date => "01-May-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "10", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "TN5306/01", :po_date => "01-Jun-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "11", :payment_term_id => "3", :payment_term_day => "0", :status => "", :remark => ""
#    ClientPo.create :po => "GN5305/01", :po_date => "10-May-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "12", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
#    ClientPo.create :po => "GN5305/02", :po_date => "31-May-2010", :po_amount => "0", :currency => "USD", :client_contract_id => "13", :payment_term_id => "1", :payment_term_day => "30", :status => "", :remark => ""
  end

  def self.down
    drop_table :client_pos
  end
end
