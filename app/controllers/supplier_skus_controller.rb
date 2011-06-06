class SupplierSkusController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'products'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'supplier_skus.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'supplier_id' #field name
          f[1][:field] = 'suppliers.name'
        elsif f[1][:field] == 'trader_sku_id'
          f[1][:field] = 'trader_skus.sku'
        elsif f[1][:field] == 'supplier_sku_id'
          f[1][:field] = 'supplier_skus.sku'
        end
      end
    end
    supplier_skus = SupplierSku.find(:all,
      :include => [:supplier,:product_mappings],
      :joins => [:trader_skus,:supplier],
      :conditions => buildFilterOptions(filter, ClientContract),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    #custom attr
    supplier_skus.collect do |item|
      item[:supplier_name] = item.supplier.name
      item[:trader_sku_id] = item.trader_skus[0].id
      item[:trader_sku] = item.trader_skus[0].sku+" - "+item.product_mappings[0].trader_sku.product.name
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = supplier_skus.total_entries
      return_data[:data] = supplier_skus.collect do |d| {
          :id => d.id,
          :trader_sku_id => d.trader_sku_id,
          :trader_sku_name => d.trader_sku,
          :supplier_sku_id => d.id,
          :supplier_sku_name => d.sku,
          :supplier_id => d.supplier_id,
          :supplier_name => d.supplier_name
        }
      end
      render :json => return_data, :layout => false
    end

  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      supplier_sku = SupplierSku.find(params[:id])
      if !supplier_sku.destroy
        supplier_sku.errors.add_to_base('Cannot delete supplier sku in use.')
      end
    else
      supplier_sku_params = {
        :sku => params[:supplier_sku_name],
        :supplier_id => params[:supplier_id]
      }
      if params[:id] == ''
        #check before insert
        supplier_sku = SupplierSku.new(supplier_sku_params)
        puts 'trader_sku'+params[:trader_sku_id]+'supplier_id'+params[:supplier_id]
        product_mappings = ProductMapping.find(:all,
          :include => [:supplier_sku],
          :conditions => ['supplier_skus.supplier_id=? and trader_sku_id=?',
            params[:supplier_id], params[:trader_sku_id]])
        puts product_mappings.count
        if product_mappings.count != 0
          supplier_sku.errors.add_to_base('can not add same product in this supplier.')
        else
          supplier_sku.product_mappings.build(:trader_sku_id => params[:trader_sku_id])
          supplier_sku.save
        end        
      else
        supplier_sku = SupplierSku.find(params[:id])
        supplier_sku.update_attributes(supplier_sku_params)
        supplier_sku.product_mappings[0].update_attributes(:trader_sku_id => params[:trader_sku_id])
      end
    end
    #display error messages
    err = Hash.new()
    if supplier_sku.errors.entries.count != 0
      supplier_sku.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = supplier_sku_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end 
  
  def get_all_trader_sku
    if request.xhr?
      sku = params[:query]
      trader_skus = TraderSku.find(:all,
        :include => [:product]) do
        sku =~ "#{sku}%" if sku != ''
      end
      return_data = Hash.new()
      return_data[:total] = trader_skus.count
      return_data[:data] = trader_skus.collect do |d| {
          :id => d.id,
          :sku => d.sku,
          :product_name => d.product.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
