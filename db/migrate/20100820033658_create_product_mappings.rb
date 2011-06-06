class CreateProductMappings < ActiveRecord::Migration
  def self.up
    create_table :product_mappings do |t|
      t.integer :trader_sku_id
      t.integer :supplier_sku_id

      t.timestamps
    end
    ProductMapping.create :trader_sku_id => "1", :supplier_sku_id => "1"
    ProductMapping.create :trader_sku_id => "2", :supplier_sku_id => "2"
    ProductMapping.create :trader_sku_id => "3", :supplier_sku_id => "3"
    ProductMapping.create :trader_sku_id => "3", :supplier_sku_id => "4"
    ProductMapping.create :trader_sku_id => "4", :supplier_sku_id => "5"
    ProductMapping.create :trader_sku_id => "5", :supplier_sku_id => "6"
    ProductMapping.create :trader_sku_id => "6", :supplier_sku_id => "7"
    ProductMapping.create :trader_sku_id => "7", :supplier_sku_id => "8"
    ProductMapping.create :trader_sku_id => "8", :supplier_sku_id => "9"
    ProductMapping.create :trader_sku_id => "5", :supplier_sku_id => "10"
  end

  def self.down
    drop_table :product_mappings
  end
end
