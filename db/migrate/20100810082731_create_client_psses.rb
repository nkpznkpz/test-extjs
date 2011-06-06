class CreateClientPsses < ActiveRecord::Migration
  def self.up
    create_table :client_psses do |t|
      t.datetime :date_sent
      t.datetime :date_receive
      t.integer :pss_status_id
      t.integer :client_order_id
    end    
  end

  def self.down
    drop_table :client_psses
  end
end
