class AddGitUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :git_uri, :string
  end
end
