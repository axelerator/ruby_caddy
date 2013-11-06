require 'fileutils'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def clone
    FileUtils.rm_rf(path)
    FileUtils.mkdir_p(path)
    Git.clone(git_uri, "#{id}", :path => self.class.root_path)
  end

  def pull
    g = Git.open(path, :log => Rails.logger)
    g.pull
  end

  def self.root_path
    "/tmp/checkout"
  end

  def path
    self.class.root_path + "/#{id}"
  end

  def tasks
    @tasks ||=[
      Task.new(path,1) do
        [
          [ {'foo' => 1, 'bar' => 2} , { foo: 1, bar: 2}],
          [ {'rum-' => 1, 'bum' => 2} , { :'rum-' =>  1, bum: 2}]
        ]
      end,


      Task.new(path, 2) do
        [
          [1000, 21124],
          [1000, 0]
        ]
      end
    ]
  end

  def self.mk_stats
    best_tasks = {}
    users = User.all.select {|u| u.git_uri.present?}
    users.each do |user|
      user.tasks.each do |task|
        if task.success? && ( best_tasks[task.i] == nil || task.length < best_tasks[task.i] )
          best_tasks[task.i] = task.length
        end
      end
    end

    stats = []
    users.each do |u|
      current_row = { tasks: {}, total: 0, user: u, solved: 0}
      stats << current_row
      u.tasks.each do |t|
        task_info = {}
        current_row[:tasks][t.i] = task_info
        task_info[:points] = t.success? ? ((t.length.to_f / best_tasks[t.i]) * 1000).to_i : 0
        current_row[:total] += task_info[:points]
        if t.success?
          current_row[:solved] += 1
        end
      end
    end
    { best: best_tasks,
      rows: stats.sort_by!{|h| h[:total]}.reverse
    }
  end

end
