class SupplierPo < ActiveRecord::Base
  belongs_to :supplier_contract
  belongs_to :payment_term
  has_many :supplier_orders
  validates_numericality_of :payment_term_day, :only_integer => true
  validates_presence_of :po, :payment_term_id, :currency
  validates_date :po_date, :invalid_date_message => I18n.t('error.date_format')
  validates_uniqueness_of :po, :scope => 'supplier_contract_id'
  # TODO: chawarong - ask P'Phob if payment_term and
  # payment_term_day needs to be present
  
  def validate_on_create
    @count_supplier_contact_record = SupplierContactRecord.count(:all,
      :conditions => ['supplier_contract_id=?',supplier_contract_id])
    if @count_supplier_contact_record == 0
      errors.add_to_base('Please Add Supplier contact record first')
      return false
    else
      return true
    end
  end
  def before_destroy
    if supplier_orders.count != 0
      return false
    else
      return true
    end
  end
end
