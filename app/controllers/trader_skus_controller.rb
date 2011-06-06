class TraderSkusController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'products'

  def index
    trader_skus = TraderSku.find(:all, :include => 'product') do
      if params[:_search] == "true"
        sku =~ "%#{params[:sku]}%" if params[:sku].present?
        product.name =~ "%#{params[:product_id]}%" if params[:product_id].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    #custom attr
    trader_skus.collect { |item|
      item[:product_name] = item.product.name
    }
    if request.xhr?
      render :json => trader_skus.to_jqgrid_json([:id,:sku,:product_name],
        params[:page], params[:rows], trader_skus.total_entries) and return
    end
  end
  
  def post_data
    response_data = {}
    if params[:oper] == "del"
      trader_sku = TraderSku.find(params[:id])
      if !trader_sku.destroy
        trader_sku.errors.add_to_base('Cannot delete trader sku in use.')
      end
    else
      trader_sku_params = {
        :sku => params[:sku],
        :product_id => params[:product_id]
      }
      if params[:id] == "_empty"
        trader_sku = TraderSku.create(trader_sku_params)
      else
        trader_sku = TraderSku.find(params[:id])
        trader_sku.update_attributes(trader_sku_params)
      end
    end
    #display error messages
    err = ""
    if trader_sku
      trader_sku.errors.entries.each do |error|
        err << "<strong>#{error[0]}</strong> : #{error[1]}<br/>"
      end
      response_data[:error] = err
    end
    render :json => response_data
  end 

end
