class CreateClientOrders < ActiveRecord::Migration
  def self.up
    create_table :client_orders do |t|
      t.float :total_quantity
      t.integer :client_PO_id
      t.integer :trader_sku_id
      t.string :request_et
      t.string :request_et_type
      t.string :unit_of_order
      t.float :unit_price

      t.timestamps
    end
#    ClientOrder.create :total_quantity => "1000", :client_PO_id => "1", :trader_sku_id => "5", :request_et => "Early February", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "300"
#    ClientOrder.create :total_quantity => "2000", :client_PO_id => "2", :trader_sku_id => "2", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "450"
#    ClientOrder.create :total_quantity => "500", :client_PO_id => "3", :trader_sku_id => "6", :request_et => "Early March", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "425"
#    ClientOrder.create :total_quantity => "500", :client_PO_id => "3", :trader_sku_id => "7", :request_et => "Early March", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "400"
#    ClientOrder.create :total_quantity => "1000", :client_PO_id => "4", :trader_sku_id => "3", :request_et => "End March", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    ClientOrder.create :total_quantity => "500", :client_PO_id => "4", :trader_sku_id => "4", :request_et => "End March", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "350"
#    ClientOrder.create :total_quantity => "3000", :client_PO_id => "5", :trader_sku_id => "1", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "500"
#    ClientOrder.create :total_quantity => "3000", :client_PO_id => "5", :trader_sku_id => "2", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "450"
#    ClientOrder.create :total_quantity => "2000", :client_PO_id => "6", :trader_sku_id => "3", :request_et => "End April", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    ClientOrder.create :total_quantity => "2000", :client_PO_id => "7", :trader_sku_id => "3", :request_et => "End May", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    ClientOrder.create :total_quantity => "1000", :client_PO_id => "8", :trader_sku_id => "5", :request_et => "20-Apr-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "300"
#    ClientOrder.create :total_quantity => "1000", :client_PO_id => "9", :trader_sku_id => "8", :request_et => "20-Apr-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "450"
#    ClientOrder.create :total_quantity => "1500", :client_PO_id => "10", :trader_sku_id => "5", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "300"
#    ClientOrder.create :total_quantity => "500", :client_PO_id => "11", :trader_sku_id => "3", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    ClientOrder.create :total_quantity => "3000", :client_PO_id => "12", :trader_sku_id => "6", :request_et => "15-May-2010, 30-May-2010", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "425"
#    ClientOrder.create :total_quantity => "3000", :client_PO_id => "13", :trader_sku_id => "7", :request_et => "15-May-2010, 30-May-2010", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "400"
#    ClientOrder.create :total_quantity => "3000", :client_PO_id => "14", :trader_sku_id => "4", :request_et => "31-May-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "350"
#    ClientOrder.create :total_quantity => "1000", :client_PO_id => "15", :trader_sku_id => "3", :request_et => "25-Jun-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    ClientOrder.create :total_quantity => "2000", :client_PO_id => "16", :trader_sku_id => "5", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "300"
#    ClientOrder.create :total_quantity => "500", :client_PO_id => "17", :trader_sku_id => "8", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "450"
  end

  def self.down
    drop_table :client_orders
  end
end
