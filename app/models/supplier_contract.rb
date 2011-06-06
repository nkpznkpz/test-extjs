class SupplierContract < ActiveRecord::Base
  belongs_to :supplier
  has_many :supplier_pos
  has_many :supplier_contact_records
  # TODO - chawarong.s - need to make it more generic
  #validates_length_of :contract_code, :is => 13, :message => I18n.t('error.supplier_contract.contract_code.length')
  validates_uniqueness_of :contract_code
  validates_date :contract_date, :invalid_date_message => I18n.t('error.date_format')
  
  validates_presence_of :supplier_id #, :message => I18n.t('error.supplier_contract.contract_code.presence_of')

  def before_destroy
    if supplier_pos.count != 0
     return false
    else
     return true
    end
  end
end
