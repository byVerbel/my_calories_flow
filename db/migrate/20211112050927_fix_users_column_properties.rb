class FixUsersColumnProperties < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :firstname, :string, default: ''
    change_column :users, :lastname, :string, default: ''
    change_column :users, :birthday, :date, default: ''
  end
end
