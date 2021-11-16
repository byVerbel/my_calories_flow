class DeleteBirthdayFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_columns :users, :birthday
  end
end
