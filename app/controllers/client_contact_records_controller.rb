class ClientContactRecordsController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'clients'

  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_contact_records.product_id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    puts sort_dir
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'product_id' #field name
          f[1][:field] = 'products.name'
        end
      end
    end
    client_contact_records = ClientContactRecord.find_all_by_client_contract_id(params[:client_contract_id],
      :include => [:product],
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
  

    client_contact_records.collect do |item|
      item[:product_name] = item.product.name
      sum_cr_per_product = ClientContactRecord.sum('total1',
        :conditions => ['product_id=? and client_contract_id=?',item.product_id, params[:client_contract_id]])

      trader_sku = TraderSku.find_by_product_id(item.product_id)
      client_contract = ClientContract.find(params[:client_contract_id])

      client_pos = ClientPo.find(:all,
        :conditions => ['client_contract_id=?', client_contract.id])
      order_quantity_sum = 0
      client_pos.each do |client_po|
        order_quantity_sum = order_quantity_sum + client_po.client_orders.sum(:total_quantity,
          :conditions => ['trader_sku_id=?',trader_sku.id])
      end
      item[:remainder] = sum_cr_per_product - order_quantity_sum
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_contact_records.count
      return_data[:data] = client_contact_records.collect do |d| {
          :id => d.id,
          :product_id => d.product_id,
          :product_name => d[:product_name],
          :total1 => d.total1,
          :remainder => d.remainder,
          :request_date => d.request_date
        }
      end
      render :json => return_data, :layout => false
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_contact_record = ClientContactRecord.find(params[:id],
        :include => [:product, :client_contract])
      client_pos = client_contact_record.client_contract.client_pos
      sum_cr_per_product = ClientContactRecord.sum('total1',
        :conditions => ['product_id=? and client_contract_id=?',client_contact_record.product_id, client_contact_record.client_contract_id])

      order_quantity_sum = 0
      client_pos.each do |client_po|
        order_quantity_sum = order_quantity_sum + client_po.client_orders.sum(:total_quantity,
          :conditions => ['trader_sku_id=?',client_contact_record.product.trader_skus[0].id])
      end
      if sum_cr_per_product - client_contact_record.total1 >= order_quantity_sum
        client_contact_record.destroy
      else
        client_contact_record.errors.add_to_base('Can not Delete,Total > Total Order Quantity.')
      end
    else
      client_contact_record_params = {
        :product_id => params[:product_id],
        :total1 => params[:total1],
        :request_date => params[:request_date],
        :status => 1,
        :client_contract_id => params[:client_contract_id]
      }

      if params[:id] == ''
        client_contact_record = ClientContactRecord.create(client_contact_record_params)
      else
        client_contact_record = ClientContactRecord.find(params[:id])
        client_contact_record.update_attributes(client_contact_record_params)
      end
    end
    #display error messages
    err = Hash.new()
    if client_contact_record.errors.entries.count != 0
      client_contact_record.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_contact_record_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end
end
