class AddChartDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :chart_digest, :string
  end
end
