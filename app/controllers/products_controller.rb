class ProductsController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'products'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'products.id') #pk master table
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

    #custom sort
    if sort_col == 'trader_sku_id'
      sort_col = 'trader_skus.sku'
    end
    products = Product.find(:all, :include => :trader_skus,
      :conditions => buildFilterOptions(filter, ClientContract),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    products.collect do |item|
      item[:trader_sku_id] = item.trader_skus[0].id
      item[:trader_sku] = item.trader_skus[0].sku
    end

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = products.total_entries
      return_data[:data] = products.collect do |d| {
          :id => d.id,
          :trader_sku_id => d.trader_sku_id,
          :trader_sku => d.trader_sku,
          :name => d.name,
          :detail => d.detail,
          :product_type => d.product_type,
          :spec => d.spec
        }
      end
      render :json => return_data, :layout=>false
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      product = Product.find(params[:id])
      if !product.destroy
        product.errors.add_to_base('Cannot delete, product in use.')
      end
    else
      product_params = {
        :name => params[:name],
        :detail => params[:detail],
        :spec => params[:spec],
        :product_type => params[:product_type]
      }
      
      if params[:id] == ''
        product = Product.new(product_params)
        product.trader_skus.build(:sku => params[:trader_sku])
        product.save
        # product.trader_skus.create()
      else
        product = Product.find(params[:id])
        product.update_attributes(product_params)
        product.trader_skus[0].update_attributes(:sku => params[:trader_sku])
      end
    end
    #display error messages
    err = Hash.new()
    if product.errors.entries.count != 0
      product.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = product_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def get_all_product
    if request.xhr?
      product_name = params[:query]
      products = Product.find_name_for_select(product_name)
      return_data = Hash.new()
      return_data[:total] = products.count
      return_data[:data] = products.collect do |d| {
          :id => d.id,
          :name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
