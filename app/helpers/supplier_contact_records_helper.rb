module SupplierContactRecordsHelper
  def supplier_cr_for_select(supplier_contact_id)
    supplier_contract = SupplierContract.find(supplier_contact_id)
    supplier_skus = SupplierSku.find(:all,
    :conditions => ['supplier_id=?',supplier_contract.supplier_id])
    #puts product_mappings.inspect
    if supplier_skus
      options ='{'
      options << %Q/value:":-----;/
      supplier_skus.each do |supplier_sku|
        product_id = supplier_sku.product_mappings[0].trader_sku.product_id
        product_name = supplier_sku.product_mappings[0].trader_sku.product.name
        options << "%s:%s - %s;" % [product_id, supplier_sku.sku, product_name]
      end

      options.chop! << %Q/",/
      options.chop! << "}"
    else
      options = '{value:":-----"}'
    end
    return options
  end
end
