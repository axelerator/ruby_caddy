require 'fileutils'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :test_results, dependent: :destroy

  def clone
    FileUtils.rm_rf(path)
    FileUtils.mkdir_p(path)
    Git.clone(git_uri, "#{id}", :path => self.class.root_path)
    update_attribute(:current_revision, sha)
  end

  def pull
    git(path).pull
    update_attribute(:current_revision, sha)
  rescue ArgumentError
    clone
  end

  def self.root_path
    "/tmp/checkout"
  end

  def path
    self.class.root_path + "/#{id}"
  end

  def test
    pull
    transaction do
      test_results.clear
      erg = Bundler.with_clean_env do
        `cd #{Rails.root.join("test_environment")} && bundle exec ruby -KU -I#{path} ruby_golf_test.rb --nocolor`
      end
      puts erg
      erg = erg.split("\n").map do |line|
        if !(matcher = /^ *(Hole [0-9]+ \([^:]+\)): (([0-9]+) character\(s\)|(FAILED|UNDEFINED|there was an error counting your characters))/.match(line)).nil?
          test_results.create(test: matcher[1], size: matcher[3])
        end
      end
      TestResult.update_scores
      User.update_scores
      reload # needed because of the way stats are updated
      update_attribute(:tested_revision, sha)
    end
  end

  def self.update_scores
    User.update_all("solved = (select count(*) from test_results where user_id = users.id and size is not null)")
    User.where("solved == 0").update_all("score = 0")
    User.where("solved > 0").update_all("score = (select sum(score) from test_results where user_id = users.id)")
  end

  private

  def git(path)
    tries = 0
    begin
      tries += 1
      Git.open(path, :log => Rails.logger)
    rescue ArgumentError => e
      clone
      tries == 1 ? retry : raise(e)
    end
  end

  def sha
    git(path).object('HEAD').sha
  end

end
