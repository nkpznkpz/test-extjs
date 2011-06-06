class CreatePssStatuses < ActiveRecord::Migration
  def self.up
    create_table :pss_statuses do |t|
      t.string :name

      t.timestamps
    end
    PssStatus.create(:name => 'status1')
    PssStatus.create(:name => 'status2')
  end

  def self.down
    drop_table :pss_statuses
  end
end
