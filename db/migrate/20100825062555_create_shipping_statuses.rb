class CreateShippingStatuses < ActiveRecord::Migration
  def self.up
    create_table :shipping_statuses do |t|
      t.string :name

      t.timestamps
    end
    ShippingStatus.create(:name => 'shipping status 1')
    ShippingStatus.create(:name => 'shipping status 2')
  end

  def self.down
    drop_table :shipping_statuses
  end
end
