class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :make_them_give_an_uri

  def index
    @highscore = User.order(score: :desc, solved: :desc, id: :asc)
    @tasks = TestResult.group(:test).order(score: :desc).all.sort_by(&:test)
  end

end
