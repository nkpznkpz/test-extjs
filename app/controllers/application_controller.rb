# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to dashboard_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  def to_date_str(d)
    if !d.nil?
      d.strftime("%Y-%m-%d %H:%M:%S")
    end
  end

  def buildFilterOptions_List(val, key)
    if val.nil? or val.empty? or key.nil? or key.empty? then return val end
    skey = key + ' = '
    rtn = ''
    cnt = 0
    if val.include? ','
      val.split(',').each {|sval|
        rtn = rtn + ' OR ' unless cnt < 1
        rtn = rtn + skey + '\''+sval+'\''
        cnt += 1
      }
      rtn = '(' + rtn + ')' unless cnt <= 1
    else
      rtn = skey + '\''+val+'\''
    end
    rtn
  end
  
  def buildFilterOptions(filter_hash,obj)

    return '' if filter_hash.nil?  #Return an empty string if the filter is empty
    fs = ''
    filter_hash = filter_hash.delete_if {|key, value| value.blank? }
    filter_hash.each do |columns, fvals|
      fs_tmp = ''

      gf_field = fvals[:field].downcase
      
      gf_type = fvals[:data][:type].downcase
      #gf_type = '' unless obj.column_names.include?(gf_field)  #Verify field name
      gf_value = fvals[:data][:value]
      gf_comparison = fvals[:data][:comparison]
      puts gf_field+'--------------------'
      case gf_type
      when 'numeric'
        case gf_comparison
        when 'gt'
          fs_tmp = '>'
        when 'lt'
          fs_tmp = '<'
        when 'eq'
          fs_tmp = '='
        when 'ne'
          fs_tmp = '!='
        end
        gf_value = gf_value.to_i
        fs_tmp = gf_field + ' ' + fs_tmp + ' ' + gf_value.to_s unless fs_tmp.empty?
      when 'string'
        fs_tmp = gf_field + ' like \'%' + gf_value + '%\''
          puts fs_tmp+'<<<<<<<<<<<<<'
      when 'boolean'
        gf_value = gf_value.downcase
        if gf_value == 'true' or gf_value == 'false'
          fs_tmp = gf_field + ' = ' + gf_value
        end
      when 'list'
        fs_tmp = buildFilterOptions_List(gf_value, gf_field)  #Need to implement your own data validation
      when 'date'
        case gf_comparison
        when 'gt'
          fs_tmp = '>'
        when 'lt'
          fs_tmp = '<'
        when 'eq'
          fs_tmp = '='
        when 'ne'
          fs_tmp = '!='
        end
        #Note: I modified DateFilter.js 'dateFormat' from 'm/d/Y' to 'Y-m-d'
        fs_tmp = gf_field + ' ' + fs_tmp + ' \'' + gf_value + '\'' unless fs_tmp.empty?
      
      end

      if not fs_tmp.empty?
        fs = fs + ' AND ' unless fs.empty?
        fs = fs + fs_tmp
      end
    end
    fs
  end 

end
