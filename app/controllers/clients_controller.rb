class ClientsController < ApplicationController  
  protect_from_forgery :except => [:post_data]
  layout  'clients'
  
  def index
    start = (params[:start] || 1).to_i
    size = (params[:limit] || 10).to_i
    sort_col = (params[:sort] || 'id')
    sort_dir = (params[:dir] || 'ASC')
    page = ((start/size).to_i)+1
    filter = params[:filter]
    
    @clients = Client.find(:all,
      :conditions => buildFilterOptions(filter, self),
      :order => "#{sort_col} #{sort_dir}"
    ).paginate(:page => page, :per_page => size)

    if request.xhr?
      return_data = Hash.new()
      return_data[:total] = @clients.total_entries
      return_data[:data] = @clients.collect do |d| {
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

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
    headers['Cache-Control'] = ''
    @clients = Client.find(:all)
  end

  
  def post_data
    response_data = {}
    if params[:oper] == "del"
      client = Client.find(params[:id])
      if !client.destroy
        client.errors.add_to_base('Cannot delete client in use.')
      end
    else
      client_params = {
        :name => params[:name],
        :country_name => params[:country_name],
        :address => params[:address],
        :status => params[:status],
      }
      if params[:id] == ''
        client = Client.create(client_params)
      else
        client = Client.find(params[:id])
        client.update_attributes(client_params)
      end
    end
    #display error messages
    err = Hash.new()
    if client.errors.entries.count != 0
      client.errors.entries.each do |error|
        err[error[0]] = error[1]
      end
      response_data[:success] = false
      response_data[:errors] = err
    else
      response_data[:data] = client_params
      response_data[:success] = true
      #response_data[:message] = 'test'
    end    
    render :json => response_data
  end
  
  def get_country    
    if request.xhr?
      countries = Country.find(:all,:order => 'name asc') do
        name =~ "#{params[:query]}%" if params[:query].present?
      end
      return_data = Hash.new()
      return_data[:total] = countries.count
      return_data[:data] = countries.collect do |d| {
          :id => d.id,
          :name => d.name
        }
      end
      render :json => return_data, :layout => false
    end
  end

  def get_all_client
    if request.xhr?
      client_name = params[:query]
      clients = Client.find_name_for_select(client_name)
      return_data = Hash.new()
      return_data[:total] = clients.count
      return_data[:data] = clients.collect do |d| {
          :id => d.id,
          :name => d.name,
          :address => d.address
        }
      end
      render :json => return_data, :layout => false
    end
  end
end
