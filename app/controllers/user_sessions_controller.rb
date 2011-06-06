class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:create]
  def create
    if request.post?
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        redirect_back_or_default dashboard_url
      else
        flash[:error] = "Invalid username or password!"
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    #flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end