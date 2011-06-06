class ClientOrdersController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'clients'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_orders.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'trader_sku_id' #field name
          f[1][:field] = 'trader_skus.sku'
        end
      end
    end
    
    client_orders = ClientOrder.find_all_by_client_PO_id(params[:client_po_id],
      :include => :trader_sku,
      :conditions => buildFilterOptions(filter, ClientOrder),      
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    #get sku name
  
    client_orders.collect do |item|
      item[:trader_sku_name] = item.trader_sku.sku + " - " + item.trader_sku.product.name
      item[:remaining_quantity] = item.total_quantity - item.client_order_fulfillments.sum('quantity')
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_orders.total_entries
      return_data[:data] = client_orders.collect do |d| {
          :id => d.id,
          :trader_sku_id => d.trader_sku_id,
          :trader_sku_name => d[:trader_sku_name],
          :total_quantity => d[:total_quantity],
          :remaining_quantity => d.remaining_quantity,
          :request_et => d.request_et,
          :request_et_type => d.request_et_type,
          :unit_of_order => d.unit_of_order,
          :unit_price => d.unit_price
        }
      end
      render :json => return_data, :layout=>false
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_order = ClientOrder.find(params[:id])
      if !client_order.destroy
        client_order.errors.add_to_base('Cannot delete client order in use.')
      end
    else
      client_order_params = { 
        :client_PO_id => params[:client_po_id],
        :total_quantity => params[:total_quantity],
        :trader_sku_id => params[:trader_sku_id],
        :request_et => params[:request_et],
        :request_et_type => params[:request_et_type],
        :unit_of_order => params[:unit_of_order],
        :unit_price => params[:unit_price]
      }    
      #puts 'xxxxxxxxxxxxxxxxx'+allow_save.to_s
      
      if params[:id] == ''
        #before save
        order_quantity_sum = ClientOrder.sum(:total_quantity,
          :conditions => ['trader_sku_id=?', params[:trader_sku_id]])
        client_po = ClientPo.find(params[:client_po_id])
        client_contract = ClientContract.find(client_po.client_contract_id)
        trader_sku = TraderSku.find(params[:trader_sku_id])
        product_id = trader_sku.product_id
        cr_sum = ClientContactRecord.sum('total1',
          :conditions => [
            'client_contract_id=? and product_id=?',
            client_contract.id,
            product_id
          ])        
        if  order_quantity_sum + params[:total_quantity].to_f <= cr_sum
          client_order = ClientOrder.create(client_order_params)
          response_data[:id] = client_order.id
        else
          client_order = ClientOrder.new(client_order_params)
          client_order.errors.add_to_base('total quantity < fulfillment quantity')
        end        
      else
        #before update
        order_quantity_sum = ClientOrder.sum(:total_quantity,
          :conditions => ['trader_sku_id=? and client_po_id=?', params[:trader_sku_id], params[:client_po_id]])
        client_po = ClientPo.find(params[:client_po_id])
        client_contract = ClientContract.find(client_po.client_contract_id)
        trader_sku = TraderSku.find(params[:trader_sku_id])
        product_id = trader_sku.product_id
        cr_sum = ClientContactRecord.sum('total1',
          :conditions => [
            'client_contract_id=? and product_id=?',
            client_contract.id,
            product_id
          ])
        current_quantity = ClientOrder.find(params[:id]).total_quantity
        if  order_quantity_sum + params[:total_quantity].to_f - current_quantity <= cr_sum
          client_order = ClientOrder.find(params[:id])
          client_order.update_attributes(client_order_params)
        else
          client_order = ClientOrder.new(client_order_params)
          client_order.errors.add_to_base('total quantity < fulfillment quantity')
        end

        
      end
    end
    #display error messages
    err = Hash.new()
    if client_order.errors.entries.count != 0
      client_order.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_order_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def show
    begin
      @client_contract = ClientContract.find(params[:client_contract_id])
      @client_po = ClientPo.find(params[:client_po_id],
        :conditions => ['client_contract_id=?',@client_contract.id])
      @client_order = ClientOrder.find(params[:id],
        :conditions => ['client_po_id=?',@client_po.id])
    rescue
      #url hacking
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end

  def get_all_trader_sku
    if request.xhr?

      products = Product.find(:all,
      :joins => [:trader_skus,:client_contact_records],
      :conditions => ['client_contact_records.client_contract_id=?', params[:client_contract_id]],
      :group => 'name') do
        name =~ "#{params[:query]}%" if params[:query].present?
      end
      return_data = Hash.new()
      return_data[:total] = products.count
      return_data[:data] = products.collect do |d| {
          :id => d.trader_skus[0].id,
          :sku => d.trader_skus[0].sku,
          :product_name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
  
end
