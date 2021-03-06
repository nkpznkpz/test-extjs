class ClientInvoiceController < ApplicationController
  protect_from_forgery :except => [:post_data, :add_fulfillment_to_invoice]
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_invoices.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]

    client_invoices = ClientInvoice.find(:all, :include => 'client_invoice_rates',
      :conditions => buildFilterOptions(filter, ClientInvoice),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    #get payment_term_name

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_invoices.total_entries
      return_data[:data] = client_invoices.collect do |d| {
          :id => d.id,
          :invoice_number => d.invoice_number,
          :invoice_date => d.invoice_date,
          :total_amount => d.total_amount,
          :payment_date => d.payment_date
        }
      end
      render :json => return_data, :layout=>false
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_invoice = ClientInvoice.find(params[:id])
      if !client_invoice.destroy
        #    client_invoice.errors.add_to_base('Cannot delete client PO in use.')
      end
    else
      client_invoice_params = {
        :invoice_number => params[:invoice_number],
        :invoice_date => params[:invoice_date],
        :total_amount => params[:total_amount],
        :payment_date => params[:payment_date]
      }
      if params[:id] == ''
        client_invoice = ClientInvoice.create(client_invoice_params)
        response_data[:id] = client_invoice.id
      else
        client_invoice = ClientInvoice.find(params[:id])
        client_invoice.update_attributes(client_invoice_params)
      end
    end
    #display error messages
    err = Hash.new()
    if client_invoice.errors.entries.count != 0
      client_invoice.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_invoice_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def show
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
    client_order_fulfillments = ClientOrderFulfillment.find_all_by_client_invoice_id(params[:client_invoice_id],
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
      render :json => return_data, :layout => false
    end
  end

  def delete_ff_invoice
    response_data = {}
    if params[:oper] == "del"
      client_invoice = ClientOrderFulfillment.find(params[:id])
      client_invoice.update_attribute('client_invoice_id', 0)
    end

    #display error messages
    err = Hash.new()
    if client_invoice.errors.entries.count != 0
      client_invoice.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end
  
  def show_client_order_fulfillment_no_invoice
    render :layout => false 
  end

  def add_fulfillment_to_invoice
    fulfillmentlist = params[:fulfillmentlist].split(',')
    puts fulfillmentlist.inspect
    @client_order_fulfillments = ClientOrderFulfillment.find(fulfillmentlist).each do |client_order_fulfillment|
      client_order_fulfillment.update_attribute :client_invoice_id, params[:client_invoice_id]
    end
    render :text => 'ok'
  end
end
