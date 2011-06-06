class ClientPosController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'clients'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'client_pos.id') #pk master table
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    #change query field
    if !filter.nil?
      filter.collect do |f|
        #   puts f[1][:data].inspect  # {"type"=>"string", "value"=>"xxxx"}
        if  f[1][:field] == 'client_id' #field name
          f[1][:field] = 'clients.name'
        elsif f[1][:field] == 'payment_term_id'
          f[1][:field] = 'payment_terms.name'
        end
      end
    end
   
    client_pos = ClientPo.find_all_by_client_contract_id(params[:client_contract_id],
      :include => [:payment_term],
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)
    client_pos.collect do |item|
      item[:payment_term_name] = item.payment_term.name
      item[:sum_total_quantity] = item.client_orders.sum('total_quantity*unit_price')
    end
    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = client_pos.total_entries
      return_data[:data] = client_pos.collect do |d| {
          :id => d.id,
          :po => d.po,
          :po_date => d.po_date,
          :sum_total_quantity => d.sum_total_quantity,
          :currency => d.currency,
          :payment_term_id => d.payment_term_id,
          :payment_term_name => d.payment_term_name,
          :payment_term_day => d.payment_term_day
        }
      end
      render :json => return_data, :layout=>false
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      client_po = ClientPo.find(params[:id])
      if !client_po.destroy
        client_po.errors.add_to_base('Cannot delete client PO in use.')
      end
    else
      client_po_params = {
        :po => params[:po],
        :po_date => params[:po_date],
        :po_amount => params[:po_amount],
        :currency => params[:currency],
        :payment_term_id => params[:payment_term_id],
        :payment_term_day => params[:payment_term_day],
        :client_contract_id => params[:client_contract_id]
      }
      if params[:id] == ''
        client_po = ClientPo.create(client_po_params)
      else
        client_po = ClientPo.find(params[:id])
        client_po.update_attributes(client_po_params)
      end
    end
    #display error messages
    err = Hash.new()
    if client_po.errors.entries.count != 0
      client_po.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_po_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end
    render :json => response_data
  end

  def show
    begin
      @client_contract = ClientContract.find(params[:client_contract_id],
        :joins => :client_pos,
        :conditions => ['client_pos.id=?',params[:id]])
      @client_po = ClientPo.find(params[:id], :include => 'payment_term')
      @sum_total_quantity = @client_po.client_orders.sum('total_quantity * unit_price')
    rescue
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end

  def get_all_payment_term
    if request.xhr?
      payment_terms = PaymentTerm.find(:all, :order => 'name asc')
      return_data = Hash.new()
      return_data[:total] = payment_terms.count
      return_data[:data] = payment_terms.collect do |d| {
          :id => d.id,
          :name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
