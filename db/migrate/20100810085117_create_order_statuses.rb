class CreateOrderStatuses < ActiveRecord::Migration
  def self.up
    create_table :order_statuses do |t|
      t.string :name
      t.timestamps
    end
    OrderStatus.create(:name => 'order status01')
    OrderStatus.create(:name => 'order status02')
  end
  def self.down
    drop_table :order_statuses
  end
end
