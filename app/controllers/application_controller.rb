class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def make_them_give_an_uri
    redirect_to edit_user_path(current_user) if current_user.git_uri.blank?
  end

end
