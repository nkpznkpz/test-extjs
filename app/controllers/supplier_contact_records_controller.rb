class SupplierContactRecordsController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'suppliers'

  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'supplier_contact_records.product_id') #pk master table
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
    supplier_contact_records = SupplierContactRecord.find_all_by_supplier_contract_id(params[:supplier_contract_id],
      :include => [:product],
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    
    supplier_contact_records.collect do |item|
      item[:product_name] = item.product.name
      item[:request_date_s] = to_date_str(item.request_date)

      sum_cr_per_product = SupplierContactRecord.sum('total1',
        :conditions => ['product_id=? and supplier_contract_id=?',item.product_id, params[:supplier_contract_id]])

      trader_sku = TraderSku.find_by_product_id(item.product_id)
      supplier_contract = SupplierContract.find(params[:supplier_contract_id])
      supplier_pos = SupplierPo.find(:all,
        :conditions => ['supplier_contract_id=?', supplier_contract.id])

      order_quantity_sum = 0

      trader_sku.product_mappings.each do |pm|
        supplier_pos.each do |supplier_po|
          order_quantity_sum = order_quantity_sum + supplier_po.supplier_orders.sum(:total_quantity,
            :conditions => ['supplier_sku_id=?',pm.supplier_sku.id])
        end
      end
      item[:remainder] = sum_cr_per_product - order_quantity_sum
    end
    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = supplier_contact_records.count
      return_data[:data] = supplier_contact_records.collect do |d| {
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
      supplier_contact_record = SupplierContactRecord.find(params[:id],
        :include => [:product, :supplier_contract])
      supplier_pos = supplier_contact_record.supplier_contract.supplier_pos
      sum_cr_per_product = SupplierContactRecord.sum('total1',
        :conditions => ['product_id=? and supplier_contract_id=?',supplier_contact_record.product_id, supplier_contact_record.supplier_contract_id])
      order_quantity_sum = 0
      supplier_pos.each do |supplier_po|
        order_quantity_sum = order_quantity_sum + supplier_po.supplier_orders.sum(:total_quantity,
          :conditions => [
            'supplier_sku_id=?',
            supplier_contact_record.product.trader_skus[0].product_mappings[0].supplier_sku.id
          ])
      end
      if sum_cr_per_product - supplier_contact_record.total1 >= order_quantity_sum
        supplier_contact_record.destroy
      else
        supplier_contact_record.errors.add_to_base('Can not Delete,Total > Total Order Quantity.')
      end
    else
      supplier_contact_record_params = {
        :product_id => params[:product_id],
        :total1 => params[:total1],
        :request_date => params[:request_date],
        :status => 1,
        :supplier_contract_id => params[:supplier_contract_id]
      }

      if params[:id] == ''
        supplier_contact_record = SupplierContactRecord.create(supplier_contact_record_params)
      else
        supplier_contact_record = SupplierContactRecord.find(params[:id])
        supplier_contact_record.update_attributes(supplier_contact_record_params)
      end
    end
    #display error messages
    err = Hash.new()
    if supplier_contact_record.errors.entries.count != 0
      supplier_contact_record.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = supplier_contact_record_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end
end
