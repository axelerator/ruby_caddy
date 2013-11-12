class AddRevisionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_revision, :string
    add_column :users, :tested_revision, :string
  end
end
