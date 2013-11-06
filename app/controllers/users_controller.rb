class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user.pull
  end

  def edit
    @user = current_user
  end

  def update
    current_user.git_uri = params[:user][:git_uri]
    current_user.save!
    current_user.clone
    redirect_to :root
  end
end
