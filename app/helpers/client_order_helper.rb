module ClientOrderHelper
  def client_product_for_select(client_contract_id)
    products = Product.find(:all,
      :joins => [:trader_skus,:client_contact_records],
      :conditions => ['client_contact_records.client_contract_id=?', client_contract_id],
      :group => 'name')
    if products.count != 0
      options ='{'
      options << %Q/value:":-----;/
      # products.trader_skus
      products.each do |o|
        options << "%s:%s - %s;" % [o.trader_skus[0].id, o.trader_skus[0].sku, o.name]
      end
      options.chop! << %Q/",/
      options.chop! << "}"
    else
      options = '{value:":-----"}'
    end
    return options
  end
end
