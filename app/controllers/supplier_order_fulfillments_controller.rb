class SupplierOrderFulfillmentsController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'suppliers'
  
  def index
    supplier_order_fulfillments = SupplierOrderFulfillment.find(:all,
      :include => [:order_status,:unit],
      :conditions => {:supplier_order_id => params[:supplier_order_id]}) do
      if params[:_search] == "true"
        quantity =~ "%#{params[:quantity]}%" if params[:quantity].present?
        order_status_id =~ "%#{params[:order_status_id]}%" if params[:order_status_id].present?
        trader_sku.sku =~ "%#{params[:trader_sku_id]}%" if params[:trader_sku_id].present?
        total_drain_weight =~ "%#{params[:total_drain_weight]}%" if params[:total_drain_weight].present?
        total_gross_weight =~ "%#{params[:total_gross_weight]}%" if params[:total_gross_weight].present?
        total_net_weight =~ "%#{params[:total_net_weight]}%" if params[:total_net_weight].present?
        container_usage =~ "%#{params[:container_usage]}%" if params[:container_usage].present?
        unit_id =~ "%#{params[:unit_id]}%" if params[:unit_id].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    #custom attr
    supplier_order_fulfillments.collect do |item|
      item[:order_status_name] = item.order_status.name
      item[:unit_name] = item.unit.name
      item[:trader_sku_s] = item.trader_sku.sku
    end
    if request.xhr?
      render :json => supplier_order_fulfillments.to_jqgrid_json([:id,:trader_sku_s,:quantity,:order_status_name,
          :total_drain_weight,:total_gross_weight,:total_net_weight,:container_usage,:unit_name],
        params[:page], params[:rows], supplier_order_fulfillments.total_entries) and return
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      SupplierOrderFulfillment.find(params[:id]).destroy
    else
      supplier_order_fulfillment_params = {
        :quantity => params[:quantity],
        :order_status_id => params[:order_status_id],
        :trader_sku_id => params[:trader_sku_id],
        :total_drain_weight => params[:total_drain_weight],
        :total_gross_weight => params[:total_gross_weight],
        :total_net_weight => params[:total_net_weight],
        :container_usage => params[:container_usage],
        :unit_id => params[:unit_id],
        :supplier_order_id => params[:supplier_order_id]
      }
      if params[:id] == "_empty"
        supplier_order_fulfillment = SupplierOrderFulfillment.create(supplier_order_fulfillment_params)
        response_data[:id] = supplier_order_fulfillment.id
      else
        supplier_order_fulfillment = SupplierOrderFulfillment.find(params[:id])
        supplier_order_fulfillment.update_attributes(supplier_order_fulfillment_params)
      end
    end
    #display error messages
    err = ""
    if supplier_order_fulfillment
      supplier_order_fulfillment.errors.entries.each do |error|
        err << "<strong>#{error[0]}</strong> : #{error[1]}<br/>"
      end
      response_data[:error] = err
    end
    render :json => response_data
  end

  def show_supplier_order_fulfillment_no_invoice
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'supplier_order_fulfillments.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'trader_sku_id' #field name
          f[1][:field] = 'trader_skus.sku'
        elsif f[1][:field] == 'order_status_id'
          f[1][:field] = 'order_statuses.name'
        elsif f[1][:field] == 'unit_id'
          f[1][:field] = 'units.name'
        end
      end
    end
    supplier_order_fulfillments = SupplierOrderFulfillment.find_all_by_supplier_invoice_id(0,
      :include => [:order_status,:trader_sku,:unit],
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => params[:page], :per_page => params[:rows])
    #custom attr
    supplier_order_fulfillments.collect do |item|
      item[:order_status_name] = item.order_status.name
      item[:unit_name] = item.unit.name
      item[:trader_sku_name] = item.trader_sku.sku
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = supplier_order_fulfillments.total_entries
      return_data[:data] = supplier_order_fulfillments.collect do |d| {
          :id => d.id,
          :supplier_sku_id => d.trader_sku_id,
          :supplier_sku_name => d.trader_sku_name,
          :quantity => d.quantity,
          :order_status_id => d.order_status_id,
          :order_status_name => d.order_status_name,
          :total_drain_weight => d.total_drain_weight,
          :total_gross_weight => d.total_gross_weight,
          :total_net_weight => d.total_net_weight,
          :container_usage => d.container_usage,
          :unit_id => d.unit_id,
          :unit_name => d.unit_name
        }
      end
      render :json => return_data, :layout=>false
    end
  end
end
