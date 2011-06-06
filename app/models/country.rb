class Country < ActiveRecord::Base

  def self.find_name_for_select
    find(:all, :order => 'name asc')
  end
end
