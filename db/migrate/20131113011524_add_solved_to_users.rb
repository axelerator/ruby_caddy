class AddSolvedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :solved, :integer, null: false, default: 0
  end
end
