class CreateCalories < ActiveRecord::Migration[6.1]
  def change
    create_table :calories do |t|
      t.integer :ammount, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
