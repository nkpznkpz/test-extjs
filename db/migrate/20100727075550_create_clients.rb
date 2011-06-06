class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.text :address
      t.string :country_name
      t.boolean :status

      t.timestamps
    end
    Client.create :name => "Novagrim", :address => "Boulogne", :country_name => "France", :status => "1"
    Client.create :name => "Weekend Foods JSC", :address => "HoChiMinh", :country_name => "Vietnam", :status => "1"
    Client.create :name => "Guangxi Nanning Hao Cong Zai Food Co.,Ltd", :address => "Guangxi", :country_name => "China", :status => "1"
    Client.create :name => "JVR Enterprises", :address => "Andhra Pradesh", :country_name => "India", :status => "1"
    Client.create :name => "Toza Natural Fruit Juices", :address => "Jakarta Raya", :country_name => "Indonesia", :status => "1"
  end

  def self.down
    drop_table :clients
  end
end
