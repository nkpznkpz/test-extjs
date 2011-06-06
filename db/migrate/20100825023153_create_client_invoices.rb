class CreateClientInvoices < ActiveRecord::Migration
  def self.up
    create_table :client_invoices do |t|
      t.string :invoice_number
      t.datetime :invoice_date
      t.float :total_amount
      t.datetime :payment_date

      t.timestamps
    end
    ClientInvoice.create :invoice_number => "VA5302/01", :invoice_date => "01-Feb-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "TF5302/01", :invoice_date => "12-Feb-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "TF5303/01", :invoice_date => "15-Mar-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "AC5303/01", :invoice_date => "02-Mar-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "FS5303/01", :invoice_date => "30-Mar-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "FS5303/02", :invoice_date => "30-Mar-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "TF5304/01", :invoice_date => "01-Apr-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "TF5305/01", :invoice_date => "01-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "KE5304/01", :invoice_date => "28-Apr-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "KE5305/03", :invoice_date => "29-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "VA5304/01", :invoice_date => "20-Apr-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "KE5305/01", :invoice_date => "03-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "KE5305/02", :invoice_date => "03-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "AC5305/01", :invoice_date => "15-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "AC5305/02", :invoice_date => "30-May-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "FS5306/01", :invoice_date => "20-Jun-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "FS5306/02", :invoice_date => "20-Jun-2010", :total_amount => "0", :payment_date => ""
    ClientInvoice.create :invoice_number => "VA5306/01", :invoice_date => "10-Jun-2010", :total_amount => "0", :payment_date => ""
  end

  def self.down
    drop_table :client_invoices
  end
end
