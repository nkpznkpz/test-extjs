class SupplierContractsController < ApplicationController
   protect_from_forgery :except => [:post_data]
   layout  'suppliers'
   
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'supplier_contracts.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'supplier_id' #field name
          f[1][:field] = 'suppliers.name'
        end
      end
    end
    supplier_contracts = SupplierContract.find(:all, :include => ['supplier'],
      :conditions => buildFilterOptions(filter, SupplierContract),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    
    #custom attr
    supplier_contracts.collect do |item|
      item[:supplier_name] = item.supplier.name
      item[:num_po] = item.supplier_pos.count
    end
    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = supplier_contracts.total_entries
      return_data[:data] = supplier_contracts.collect do |d| {
          :id => d.id,
          :contract_code => d.contract_code,
          :contract_date => d.contract_date,
          :actual_contract => d.actual_contract,
          :supplier_id => d.supplier_id,
          :supplier_name => d.supplier_name,
          :num_po => d.num_po,
          :status => d.status,
          :remark => d.remark
        }
      end
      render :json => return_data, :layout=>false
    end
  end
  # GET /supplier_contracts/1
  # GET /supplier_contracts/1.xml
  def show
    @supplier_contract = SupplierContract.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @supplier_contract }
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      supplier_contract = SupplierContract.find(params[:id])
      if !supplier_contract.destroy
        supplier_contract.errors.add_to_base('Cannot delete supplier contract in use.')
      end
    else
      supplier_contract_params = {
        :contract_code => params[:contract_code],
        :contract_date => params[:contract_date],
        :supplier_id => params[:supplier_id],
        :actual_contract => true
      }
      if params[:id] == ''
        supplier_contract = SupplierContract.create(supplier_contract_params)
        response_data[:id] = supplier_contract.id
      else
        supplier_contract = SupplierContract.find(params[:id])
        supplier_contract.update_attributes(supplier_contract_params)
      end
    end
    #display error messages
    err = Hash.new()
    if supplier_contract.errors.entries.count != 0
      supplier_contract.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = supplier_contract_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end
end
