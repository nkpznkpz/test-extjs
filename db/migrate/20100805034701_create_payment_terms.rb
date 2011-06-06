class CreatePaymentTerms < ActiveRecord::Migration
  def self.up
    create_table :payment_terms do |t|
      t.string :name

      t.timestamps
    end
    PaymentTerm.create :name => 'T/T'
    PaymentTerm.create :name => 'L/C'
    PaymentTerm.create :name => 'D/P'
    PaymentTerm.create :name => 'D/A'
  end

  def self.down
    drop_table :payment_terms
  end
end
