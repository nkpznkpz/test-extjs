class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :detail
      t.string :product_type
      t.string :spec

      t.timestamps
    end
    Product.create :name => "Durian", :detail => "Durian Monthong", :product_type => "Dried", :spec => "Puree"
    Product.create :name => "Mango", :detail => "Nam Duk Mai", :product_type => "Dried", :spec => "Puree"
    Product.create :name => "Strawberry", :detail => "IQF Strawberry", :product_type => "Frozen", :spec => "-"
    Product.create :name => "Kiwi", :detail => "IQF Kiwi", :product_type => "Frozen", :spec => "-"
    Product.create :name => "Corn", :detail => "Yellow Corn", :product_type => "Dried", :spec => "-"
    Product.create :name => "Apple", :detail => "Fuji Apple", :product_type => "Fresh", :spec => "-"
    Product.create :name => "Fresh Grape", :detail => "White Grape", :product_type => "Fresh", :spec => "-"
    Product.create :name => "Dried Grape", :detail => "White Grape", :product_type => "Dried", :spec => "Puree"
  end

  def self.down
    drop_table :products
  end
end
