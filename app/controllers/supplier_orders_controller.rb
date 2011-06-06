class SupplierOrdersController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'suppliers'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'supplier_orders.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'supplier_sku_id' #field name
          f[1][:field] = 'supplier_skus.sku'
        end
      end
    end
    supplier_orders = SupplierOrder.find_all_by_supplier_PO_id(params[:supplier_po_id],
      :include => [:supplier_sku, :supplier_order_fulfillments],
      :conditions => buildFilterOptions(filter, SupplierOrder),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    #get sku name and current stock
   
    supplier_orders.collect do |item|
      item[:supplier_sku_name] = item.supplier_sku.sku + " - " + item.supplier_sku.product_mappings[0].trader_sku.product.name
      c_ff_sum = ClientOrderFulfillment.sum(:quantity,
        :conditions => ['supplier_order_fulfillment_id=?',item.id])
      item[:stock] = item.total_quantity - c_ff_sum    
    end
    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = supplier_orders.total_entries
      return_data[:data] = supplier_orders.collect do |d| {
          :id => d.id,
          :supplier_sku_id => d.supplier_sku_id,
          :supplier_sku_name => d[:supplier_sku_name],
          :total_quantity => d[:total_quantity],
          :remaining_quantity => d.stock,
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
      supplier_order = SupplierOrder.find(params[:id])
      if !supplier_order.destroy
        supplier_order.errors.add_to_base('Can not delete, supplier order is fulfilled.')
      end
    else
      supplier_order_params = {
        :supplier_PO_id => params[:supplier_po_id],
        :total_quantity => params[:total_quantity],
        :supplier_sku_id => params[:supplier_sku_id],
        :request_et => params[:request_et],
        :request_et_type => params[:request_et_type],
        :unit_of_order => params[:unit_of_order],
        :unit_price => params[:unit_price]
      }
      if params[:id] == ''
        #before save
        order_quantity_sum = SupplierOrder.sum(:total_quantity,
          :conditions => ['supplier_sku_id=?', params[:supplier_sku_id]])
        supplier_po = SupplierPo.find(params[:supplier_po_id])
        supplier_contract = SupplierContract.find(supplier_po.supplier_contract_id)
        supplier_sku = SupplierSku.find(params[:supplier_sku_id])
        product_id = supplier_sku.product_mappings[0].trader_sku.product_id
        cr_sum = SupplierContactRecord.sum('total1',
          :conditions => [
            'supplier_contract_id=? and product_id=?',
            supplier_contract.id,
            product_id
          ])
        supplier_order = SupplierOrder.new(supplier_order_params)
        if  order_quantity_sum + params[:total_quantity].to_f <= cr_sum          
          supplier_order.supplier_order_fulfillments.build(:quantity => params[:total_quantity])
          supplier_order.save
          response_data[:id] = supplier_order.id
        else
          supplier_order.errors.add_to_base('total quantity < fulfillment quantity')      
        end        
      else
        #before update
        order_quantity_sum = SupplierOrder.sum(:total_quantity,
          :conditions => ['supplier_sku_id=? and supplier_po_id=?', params[:supplier_sku_id], params[:supplier_po_id]])
        supplier_po = SupplierPo.find(params[:supplier_po_id])
        supplier_contract = SupplierContract.find(supplier_po.supplier_contract_id)
        supplier_sku = SupplierSku.find(params[:supplier_sku_id])
        product_id = supplier_sku.product_mappings[0].trader_sku.product_id
        cr_sum = SupplierContactRecord.sum('total1',
          :conditions => [
            'supplier_contract_id=? and product_id=?',
            supplier_contract.id,
            product_id
          ])
        current_quantity = SupplierOrder.find(params[:id]).total_quantity        
        if  order_quantity_sum + params[:total_quantity].to_f - current_quantity <= cr_sum
          supplier_order = SupplierOrder.find(params[:id])
          supplier_order.update_attributes(supplier_order_params)
          supplier_order.supplier_order_fulfillments[0].update_attributes(:quantity => params[:total_quantity])
        else
          supplier_order = SupplierOrder.new(supplier_order_params)
          supplier_order.errors.add_to_base('total quantity < fulfillment quantity')
        end
      end
    end
    #display error messages
    err = Hash.new()
    if supplier_order.errors.entries.count != 0
      supplier_order.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = supplier_order_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def show
    begin
      @supplier_contract = SupplierContract.find(params[:supplier_contract_id])
      @supplier_po = SupplierPo.find(params[:supplier_po_id],
        :conditions => ['supplier_contract_id=?',@supplier_contract.id])
      @supplier_order = SupplierOrder.find(params[:id],
        :conditions => ['supplier_po_id=?',@supplier_po.id])
    rescue
      #url hacking
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end

  def get_all_supplier_sku
    if request.xhr?
      products = Product.find(:all,
        :joins => [:trader_skus,:supplier_contact_records],
        :conditions => ['supplier_contact_records.supplier_contract_id=?',params[:supplier_contract_id]],
        :group => 'name')do
        name =~ "#{params[:query]}%" if params[:query].present?
      end

      # products.trader_skus
      data = []
      products.each do |p|
        p.trader_skus[0].product_mappings.each do |pm|
          tmp = {
            :id => pm.supplier_sku.id,
            :sku => pm.supplier_sku.sku,
            :product_name => p.name
          }
          data << tmp
        end
      end


      return_data = Hash.new()
      return_data[:total] = data.count
      return_data[:data] = data
      
      render :json => return_data, :layout => false
    end
  end

end
