class ClientOrderFulfillmentsController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'clients'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_order_fulfillments.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'supplier_sku_id' #field name
          f[1][:field] = 'supplier_skus.sku'
        elsif f[1][:field] == 'order_status_id'
          f[1][:field] = 'order_statuses.name'
        elsif f[1][:field] == 'unit_id'
          f[1][:field] = 'units.name'
        end
      end
    end
    client_order_fulfillments = ClientOrderFulfillment.find_all_by_client_order_id(params[:client_order_id],
      :include => [:order_status,:unit,:supplier_sku],
      :conditions => buildFilterOptions(filter, ClientOrderFulfillment),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => params[:page], :per_page => params[:rows])
    #custom attr
    client_order_fulfillments.collect do |item|
      item[:order_status_name] = item.order_status.name
      item[:unit_name] = item.unit.name
      item[:supplier_sku_name] = item.supplier_sku.sku + " - " + item.supplier_sku.product_mappings[0].trader_sku.product.name
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_order_fulfillments.total_entries
      return_data[:data] = client_order_fulfillments.collect do |d| {
          :id => d.id,
          :supplier_sku_id => d.supplier_sku_id,
          :supplier_sku_name => d.supplier_sku_name,
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
  
  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_order_fulfillment = ClientOrderFulfillment.find(params[:id]).destroy
    else
      client_order_fulfillment_params = { 
        :quantity => params[:quantity],
        :order_status_id => params[:order_status_id],
        # :supplier_sku_id => params[:supplier_sku_id], #supplier_order_fulfillment_id
        :total_drain_weight => params[:total_drain_weight],
        :total_gross_weight => params[:total_gross_weight],
        :total_net_weight => params[:total_net_weight],
        :container_usage => params[:container_usage],
        :unit_id => params[:unit_id],
        :client_order_id => params[:client_order_id]
      }
      #query supplier_order_fulfillment
      supplier_order_fulfillment_id = params[:supplier_sku_id]
      supplier_order_fulfillment = SupplierOrderFulfillment.find(supplier_order_fulfillment_id,
        :include => [:supplier_order])
      supplier_order = SupplierOrder.find(supplier_order_fulfillment.supplier_order_id,
        :include => :supplier_sku)
      client_order_fulfillment_params[:client_invoice_id] = 0
      client_order_fulfillment_params[:supplier_sku_id] = supplier_order.supplier_sku_id
      client_order_fulfillment_params[:supplier_order_fulfillment_id] = supplier_order_fulfillment_id
      #check stock
      ff_quantity_sum = ClientOrderFulfillment.sum(:quantity,
        :conditions => ['supplier_order_fulfillment_id=?', supplier_order_fulfillment_id])
      
      if params[:id] == ''
        client_order_fulfillment = ClientOrderFulfillment.new(client_order_fulfillment_params)
        if ClientOrderFulfillment
          if client_order_fulfillment_params[:quantity].to_f + ff_quantity_sum <= supplier_order_fulfillment.quantity
            client_order_fulfillment = ClientOrderFulfillment.create(client_order_fulfillment_params)            
          else
            client_order_fulfillment.errors.add_to_base('quantity > stock')
          end
        end
      else
        client_order_fulfillment = ClientOrderFulfillment.find(params[:id])
        if client_order_fulfillment_params[:quantity].to_f + ff_quantity_sum - client_order_fulfillment.quantity <= supplier_order_fulfillment.quantity
          client_order_fulfillment.update_attributes(client_order_fulfillment_params)
        else
          client_order_fulfillment.errors.add_to_base('quantity > stock')
        end
      end
    end
    #display error messages
    err = Hash.new()
    if client_order_fulfillment.errors.entries.count != 0
      client_order_fulfillment.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_order_fulfillment_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def show_client_order_fulfillment_no_invoice
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_order_fulfillments.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'supplier_sku_id' #field name
          f[1][:field] = 'supplier_skus.sku'
        elsif f[1][:field] == 'order_status_id'
          f[1][:field] = 'order_statuses.name'
        elsif f[1][:field] == 'unit_id'
          f[1][:field] = 'units.name'
        end
      end
    end
    client_order_fulfillments = ClientOrderFulfillment.find_all_by_client_invoice_id(0,
      :include => [:order_status,:supplier_sku,:unit],
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => params[:page], :per_page => params[:rows])
    #custom attr
    client_order_fulfillments.collect do |item|
      item[:order_status_name] = item.order_status.name
      item[:unit_name] = item.unit.name
      item[:supplier_sku_name] = item.supplier_sku.sku
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_order_fulfillments.total_entries
      return_data[:data] = client_order_fulfillments.collect do |d| {
          :id => d.id,
          :supplier_sku_id => d.supplier_sku_id,
          :supplier_sku_name => d.supplier_sku_name,
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

  def get_all_supplier_sku
    if request.xhr?
      product_mappings = ProductMapping.find_all_by_trader_sku_id(params[:trader_sku_id],
        :joins => [:supplier_sku]) do
        name =~ "#{params[:query]}%" if params[:query].present?
      end
      data = []
      product_mappings.each do |pm|
        pm.supplier_sku.supplier_orders.each do |so|
          so.supplier_order_fulfillments.each do |soff|
            if soff.quantity != 0
              tmp = {
                :id => soff.id,
                :supplier_sku => pm.supplier_sku.sku,
                :product_name => pm.trader_sku.product.name
              }
              data << tmp
            end
          end
        end
      end

      #      countries = Country.find(:all,:order => 'name asc') do
      #        name =~ "#{params[:query]}%" if params[:query].present?
      #      end
      return_data = Hash.new()
      return_data[:total] = data.count
      return_data[:data] = data

      render :json => return_data, :layout => false
    end
  end

  def get_all_order_status
    if request.xhr?
      order_status = OrderStatus.find_name_for_select() do
        name =~ "#{params[:query]}%" if params[:query].present?
      end
      return_data = Hash.new()
      return_data[:total] = order_status.count
      return_data[:data] = order_status.collect do |d| {
          :id => d.id,
          :name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
  
  def get_all_unit
    if request.xhr?
      units = Unit.find_name_for_select() do
        name =~ "#{params[:query]}%" if params[:query].present?
      end
      return_data = Hash.new()
      return_data[:total] = units.count
      return_data[:data] = units.collect do |d| {
          :id => d.id,
          :name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
