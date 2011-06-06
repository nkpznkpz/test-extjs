module SupplierSkusHelper
  def supplier_sku_product_for_select
    trader_skus = TraderSku.find(:all,
      :include => [:product])
    if trader_skus.count !=0
      options ='{'
      options << %Q/value:":-----;/
      # products.trader_skus
      trader_skus.each do |t|
        options << "%s:%s - %s;" % [t.id, t.sku, t.product.name]
      end
      options.chop! << %Q/",/
      options.chop! << "}"
    else
      options = '{value:":-----"}'
    end
    return options
  end
end
