class AddSalesCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :sales_count, :integer
  end
end
