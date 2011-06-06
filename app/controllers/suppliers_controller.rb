class SuppliersController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'suppliers'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'id')
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    
    suppliers = Supplier.find(:all,
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = suppliers.total_entries
      return_data[:data] = suppliers.collect do |d| {
          :id => d.id,
          :name => d.name,
          :country_name => d.country_name,
          :address => d.address,
          :status => d.status
        }
      end
      render :json => return_data, :layout=>false
    end
  end
  
  def post_data
    response_data = {}
    if params[:oper] == "del"
      supplier = Supplier.find(params[:id])
      if !supplier.destroy
        supplier.errors.add_to_base('Cannot delete supplier in use.')
      end
    else
      supplier_params = {
        :name => params[:name],
        :address => params[:address],
        :country_name => params[:country_name],
        :status => params[:status] 
      }
      if params[:id] == ''
        supplier = Supplier.create(supplier_params)
      else
        supplier = Supplier.find(params[:id])
        supplier.update_attributes(supplier_params)
      end
    end    
    #display error messages
    err = Hash.new()
    if supplier.errors.entries.count != 0
      supplier.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = supplier_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def get_all_supplier
    if request.xhr?
      supplier_name = params[:query]
      suppliers = Supplier.find_name_for_select(supplier_name)
      return_data = Hash.new()
      return_data[:total] = suppliers.count
      return_data[:data] = suppliers.collect do |d| {
          :id => d.id,
          :name => d.name,
          :address => d.address
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
