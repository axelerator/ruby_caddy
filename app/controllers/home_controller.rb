class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :make_them_give_an_uri, except: :info

  def info
  end

  def index
    @highscore = User.order(score: :desc, solved: :desc, id: :asc)
    @holes = TestResult.all.group_by(&:test).map do |test, results|
      [
        test,
        results.sort_by do |result|
          result.size || 1_000_000_000
        end
      ]
    end
  end

end
