class CreateClientInvoiceRates < ActiveRecord::Migration
  def self.up
    create_table :client_invoice_rates do |t|
      t.string :exchange_rate
      t.datetime :settlement_date
      t.integer :client_invoice_id

      t.timestamps
    end
  end

  def self.down
    drop_table :client_invoice_rates
  end
end
