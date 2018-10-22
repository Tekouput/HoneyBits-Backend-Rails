class AddColumnsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :name, :string
    add_column :products, :description, :string
    add_column :products, :price, :decimal
    add_column :products, :rating, :float
    add_column :products, :shop_id, :integer
  end
end
