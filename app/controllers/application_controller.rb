# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  def authenticate
    session[:login_counter] = 0 if session[:login_counter].blank?
    session[:realm] = session[:session_id].to_s + '_' + session[:login_counter].to_s if session[:realm].blank?
    authenticate_or_request_with_http_basic(session[:realm]) do |user_name, password|
      if user_name == 'admin' && password == 'password'
        session[:current_user] = user_name
      end
    end
  end
end
