# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    session[:current_user]
  end
end
