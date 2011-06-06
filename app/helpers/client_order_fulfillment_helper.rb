module ClientOrderFulfillmentHelper
  def client_ff_product_for_select(trader_sku_id)
    puts trader_sku_id
    product_mappings = ProductMapping.find(:all,
      :joins => [:supplier_sku],
      :conditions => ['trader_sku_id=?', trader_sku_id])
    #puts product_mappings.inspect
    if product_mappings
      options ='{'
      options << %Q/value:":-----;/
      product_mappings.each do |pm|
        pm.supplier_sku.supplier_orders.each do |so|
          so.supplier_order_fulfillments.each do |soff|
            if soff.quantity != 0
              options << "%s:%s - %s;" % [soff.id, pm.supplier_sku.sku, pm.trader_sku.product.name]
            end
          end
        end
      end     
      options.chop! << %Q/",/
      options.chop! << "}"
    else
      options = '{value:":-----"}'
    end
    return options
  end
end
