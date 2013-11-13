class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.git_uri.blank?
      redirect_to edit_user_path(current_user)
    end
    @highscore = User.order(score: :desc, solved: :desc, id: :asc)
    @tasks = TestResult.group(:test).order(score: :desc).all.sort_by(&:test)
  end

end
