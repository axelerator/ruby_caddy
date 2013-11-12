class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.string :test, null: false
      t.integer :size, null: true
      t.integer :score, null: false, default: 0
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
