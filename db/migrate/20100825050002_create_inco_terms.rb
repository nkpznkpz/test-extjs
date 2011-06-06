class CreateIncoTerms < ActiveRecord::Migration
  def self.up
    create_table :inco_terms do |t|
      t.string :name

      t.timestamps
    end
    IncoTerm.create(:name => 'Inco term 1')
    IncoTerm.create(:name => 'Inco term 2')
    IncoTerm.create(:name => 'Inco term 3')
  end

  def self.down
    drop_table :inco_terms
  end
end
