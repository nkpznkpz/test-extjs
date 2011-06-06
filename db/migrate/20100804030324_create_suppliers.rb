class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name
      t.text :address
      t.string :country_name
      t.boolean :status
      t.timestamps
    end
    Supplier.create :name => "Kamet for Export & Import", :address => "Alexandria", :country_name => "Egypt", :status => "1"
    Supplier.create :name => "Four Season Foods Co., Ltd.", :address => "Jiangsu", :country_name => "China", :status => "1"
    Supplier.create :name => "Thaiaochi Fruits Co Ltd", :address => "Bangkok", :country_name => "Thailand", :status => "1"
    Supplier.create :name => "Volgaa Agro Products (India) Pvt Ltd", :address => "New Delhi", :country_name => "India", :status => "1"
    Supplier.create :name => "Agroseed Cooperation", :address => "Limpopo", :country_name => "South Africa", :status => "1"
  end

  def self.down
    drop_table :suppliers
  end
end
