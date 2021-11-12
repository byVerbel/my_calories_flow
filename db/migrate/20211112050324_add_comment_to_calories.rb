class AddCommentToCalories < ActiveRecord::Migration[6.1]
  def change
    add_column :calories, :register_comment, :string, default: ''
  end
end
