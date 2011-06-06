class CreateSupplierOrders < ActiveRecord::Migration
  def self.up
    create_table :supplier_orders do |t|
      t.float :total_quantity
      t.integer :supplier_PO_id
      t.integer :supplier_sku_id
      t.string :request_et
      t.string :request_et_type
      t.string :unit_of_order
      t.float :unit_price
      
      t.timestamps
    end
#    SupplierOrder.create :total_quantity => "1000", :supplier_PO_id => "1", :supplier_sku_id => "6", :request_et => "Early February", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "200"
#    SupplierOrder.create :total_quantity => "2000", :supplier_PO_id => "2", :supplier_sku_id => "3", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "375"
#    SupplierOrder.create :total_quantity => "500", :supplier_PO_id => "3", :supplier_sku_id => "7", :request_et => "Early March", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "360"
#    SupplierOrder.create :total_quantity => "500", :supplier_PO_id => "3", :supplier_sku_id => "8", :request_et => "Early March", :request_et_type => "etd", :unit_of_order => "mt", :unit_price => "320"
#    SupplierOrder.create :total_quantity => "1000", :supplier_PO_id => "4", :supplier_sku_id => "4", :request_et => "End March", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "335"
#    SupplierOrder.create :total_quantity => "500", :supplier_PO_id => "4", :supplier_sku_id => "5", :request_et => "End March", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "275"
#    SupplierOrder.create :total_quantity => "3000", :supplier_PO_id => "5", :supplier_sku_id => "1", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "400"
#    SupplierOrder.create :total_quantity => "3000", :supplier_PO_id => "5", :supplier_sku_id => "2", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "375"
#    SupplierOrder.create :total_quantity => "2000", :supplier_PO_id => "6", :supplier_sku_id => "3", :request_et => "End April", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "330"
#    SupplierOrder.create :total_quantity => "2000", :supplier_PO_id => "7", :supplier_sku_id => "3", :request_et => "End May", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "330"
#    SupplierOrder.create :total_quantity => "1000", :supplier_PO_id => "8", :supplier_sku_id => "6", :request_et => "20-Apr-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "200"
#    SupplierOrder.create :total_quantity => "1000", :supplier_PO_id => "9", :supplier_sku_id => "9", :request_et => "20-Apr-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "375"
#    SupplierOrder.create :total_quantity => "1500", :supplier_PO_id => "10", :supplier_sku_id => "10", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "225"
#    SupplierOrder.create :total_quantity => "500", :supplier_PO_id => "11", :supplier_sku_id => "3", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "330"
#    SupplierOrder.create :total_quantity => "3000", :supplier_PO_id => "12", :supplier_sku_id => "7", :request_et => "15-May-2010, 30-May-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "360"
#    SupplierOrder.create :total_quantity => "3000", :supplier_PO_id => "13", :supplier_sku_id => "8", :request_et => "15-May-2010, 30-May-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "320"
#    SupplierOrder.create :total_quantity => "3000", :supplier_PO_id => "14", :supplier_sku_id => "5", :request_et => "31-May-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "275"
#    SupplierOrder.create :total_quantity => "1000", :supplier_PO_id => "15", :supplier_sku_id => "3", :request_et => "25-Jun-2010", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "335"
#    SupplierOrder.create :total_quantity => "2000", :supplier_PO_id => "16", :supplier_sku_id => "6", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "200"
#    SupplierOrder.create :total_quantity => "500", :supplier_PO_id => "17", :supplier_sku_id => "9", :request_et => "-", :request_et_type => "etd", :unit_of_order => "drum", :unit_price => "375"
  end

  def self.down
    drop_table :supplier_orders
  end
end
