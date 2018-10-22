class AddRaitersToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :rate_count, :integer
  end
end
