class ChangeCaloriesAmmountColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_default :calories, :ammount, 0
  end
end
