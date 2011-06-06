class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.string :unit_per_container
      t.timestamps
    end
    Unit.create(:name => 'drum1')
    Unit.create(:name => 'drum2')
  end

  def self.down
    drop_table :units
  end
end
