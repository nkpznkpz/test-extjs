class CreateTraderSkus < ActiveRecord::Migration
  def self.up
    create_table :trader_skus do |t|
      t.string :sku
      t.integer :product_id

      t.timestamps
    end
    TraderSku.create :sku => "TD0001", :product_id => "1"
    TraderSku.create :sku => "TD0002", :product_id => "2"
    TraderSku.create :sku => "TD0003", :product_id => "3"
    TraderSku.create :sku => "TD0004", :product_id => "4"
    TraderSku.create :sku => "TD0005", :product_id => "5"
    TraderSku.create :sku => "TD0006", :product_id => "6"
    TraderSku.create :sku => "TD0007", :product_id => "7"
    TraderSku.create :sku => "TD0008", :product_id => "8"
  end

  def self.down
    drop_table :trader_skus
  end
end
