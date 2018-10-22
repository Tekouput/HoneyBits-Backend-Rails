class AddColumnToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :open, :bool
  end
end
