class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    if current_user.git_uri.blank?
      redirect_to edit_user_path(current_user)
    end
    @users = User.all
    current_user.pull if current_user.git_uri
    @stats = User.mk_stats
  end


end
