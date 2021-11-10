class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :calories, :type, :register_type
  end
end
