class Client < ActiveRecord::Base
  has_many :client_contracts
  # TODO: ask P'Phob if this has to be unique
  validates_uniqueness_of :name
  
  validates_presence_of :name, :country_name, :address
  validates_format_of :name, :with => /\A[^\'\"]*\Z/i, :message => "cannot contain \' or \"."

  #  include AASM
  #  aasm_column :status
  #  aasm_initial_state 0
  #  aasm_state 0
  #  aasm_state 1
  #
  #  aasm_event :set_active do
  #    transitions :from => 0, :to => 1
  #  end
  #
  #  aasm_event :set_inactive do
  #    transitions :from => 1, :to => 0
  #  end
  
  def self.find_name_for_select(client_name)
    find(:all,:conditions => ['status=?',true]) do
      name =~ "#{client_name}%" if client_name != ''
    end
  end
  
  def before_destroy
    if client_contracts.count != 0
      return false
    else
      return true
    end
  end
end
