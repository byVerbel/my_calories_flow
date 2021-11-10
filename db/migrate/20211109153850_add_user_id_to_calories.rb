class AddUserIdToCalories < ActiveRecord::Migration[6.1]
  def change
    add_column :calories, :user_id, :integer
    add_index :calories, :user_id
  end
end
