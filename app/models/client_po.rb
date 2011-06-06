class ClientPo < ActiveRecord::Base
  belongs_to :client_contract
  belongs_to :payment_term
  has_many :client_orders

  validates_presence_of :po, :payment_term_id, :currency, :payment_term_day
  validates_numericality_of :payment_term_day, :only_integer => true  
  validates_date :po_date, :invalid_date_message => I18n.t('error.date_format')
  validates_uniqueness_of :po, :scope => 'client_contract_id'
  # TODO: chawarong - ask P'Phob if payment_term and
  # payment_term_day needs to be present
  def validate_on_create
    @count_client_contact_record = ClientContactRecord.count(:all,
      :conditions => ['client_contract_id=?',client_contract_id])
    if @count_client_contact_record == 0
      errors.add_to_base('Please Add Client contact record first')
      return false
    else
      return true
    end
  end
  
  def before_destroy
    if client_orders.count != 0
      return false
    else
      return true
    end
  end
end
