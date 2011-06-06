class ClientContractsController < ApplicationController
  protect_from_forgery :except => [:post_data]
  layout  'clients'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_contracts.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'client_id' #field name
          f[1][:field] = 'clients.name'
        end
      end
    end
    client_contracts = ClientContract.find(:all,:include => ['client'],
      :conditions => buildFilterOptions(filter, ClientContract),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
  
    #custom attr
    client_contracts.collect do |item|
      item[:client_name] = item.client.name
      item[:num_po] = item.client_pos.count
    end
    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_contracts.total_entries
      return_data[:data] = client_contracts.collect do |d| {
          :id => d.id,
          :contract_code => d.contract_code,
          :contract_date => d.contract_date,
          :actual_contract => d.actual_contract,
          :client_id => d.client_id,
          :client_name => d.client_name,
          :num_po => d.num_po,
          :status => d.status,
          :remark => d.remark
        }
      end
      render :json => return_data, :layout=>false
    end
  end
  # GET /client_contracts/1
  # GET /client_contracts/1.xml
  def show
    @client_contract = ClientContract.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client_contract }
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_contract = ClientContract.find(params[:id])
      if !client_contract.destroy
        client_contract.errors.add_to_base('Cannot delete client contract in use.')
      end
    else
      client_contract_params = {
        :contract_code => params[:contract_code],
        :contract_date => params[:contract_date],
        :client_id => params[:client_id],
        :actual_contract => true
        #  :status => params[:status]
      }
      if params[:id] == ''
        client_contract = ClientContract.create(client_contract_params)
        response_data[:id] = client_contract.id
      else
        client_contract = ClientContract.find(params[:id])
        client_contract.update_attributes(client_contract_params)
      end
    end
    #display error messages
    err = Hash.new()
    if client_contract.errors.entries.count != 0
      client_contract.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_contract_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

end
