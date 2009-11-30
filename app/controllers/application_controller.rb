# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # post requests will require (unless turned off for an action) an authenticity token
  protect_from_forgery

  # view helpers
  helper :all
  helper_method :current_user_session, :current_user

  # make sure passwords don't show up in the logs
  filter_parameter_logging :password, :password_confirmation

  private

  # fetch, or create the current user session
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  # fetch, or authenticate the current user
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
    true
  end

  def require_admin
    return false unless require_user
    unless current_user.admin?
      store_location
      flash[:error] = "You must be logged in as an administrator to access this page"
      redirect_to :back
      return false
    end
    true
  end

  def store_location(type = :current)
    session[:return_to] = (type == :referrer) ? request.referrer : request.request_uri
  end

  def location_stored?
    !session[:return_to].nil?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
