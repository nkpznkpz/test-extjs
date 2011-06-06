class CreateSupplierSkus < ActiveRecord::Migration
  def self.up
    create_table :supplier_skus do |t|
      t.string :sku
      t.integer :supplier_id
      
      t.timestamps
    end
    SupplierSku.create :sku => "TF0001", :supplier_id => "3"
    SupplierSku.create :sku => "TF0002", :supplier_id => "3"
    SupplierSku.create :sku => "KE0001", :supplier_id => "1"
    SupplierSku.create :sku => "FS0001", :supplier_id => "2"
    SupplierSku.create :sku => "FS0002", :supplier_id => "2"
    SupplierSku.create :sku => "VA0001", :supplier_id => "4"
    SupplierSku.create :sku => "AC0001", :supplier_id => "5"
    SupplierSku.create :sku => "AC0002", :supplier_id => "5"
    SupplierSku.create :sku => "VA0002", :supplier_id => "4"
    SupplierSku.create :sku => "KE0002", :supplier_id => "1"
  end

  def self.down
    drop_table :supplier_skus
  end
end
