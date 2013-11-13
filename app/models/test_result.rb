class TestResult < ActiveRecord::Base
  belongs_to :user

  def solved?
    !size.nil?
  end

  def self.update_scores
    update_all("score = (select min(size) * 1.0 from test_results tr where tr.size is not null and tr.test = test_results.test) / size * 1000", "size is not null")
  end
end
