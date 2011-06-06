class ClientContract < ActiveRecord::Base
  belongs_to :client
  has_many :client_pos
  has_many :client_contact_records
  # TODO - chawarong.s - need to make it more generic
  validates_length_of :contract_code, :is => 13, :message => I18n.t('error.client_contract.contract_code.length')
  validates_uniqueness_of :contract_code
  validates_presence_of :client_id, :message => I18n.t('error.client_contract.contract_code.presence_of')
  validates_date :contract_date, :invalid_date_message => I18n.t('error.date_format')

  def before_destroy
    if client_pos.count != 0
     return false
    else
     return true
    end
  end
end
