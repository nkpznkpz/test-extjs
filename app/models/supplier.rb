class Supplier < ActiveRecord::Base
  has_many :supplier_skus
  validates_presence_of :name, :country_name, :address
  validates_uniqueness_of :name
  # TODO: ask p'phob if name has to be unique.
  def self.find_name_for_select(supplier_name)
     find(:all,:conditions => ['status=?',true]) do
      name =~ "#{supplier_name}%" if supplier_name != ''
    end
  end
end
