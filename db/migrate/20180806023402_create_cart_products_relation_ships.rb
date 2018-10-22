class CreateCartProductsRelationShips < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_products_relation_ships do |t|
      t.string :cart_id
      t.string :product_id
      t.string :shop_id

      t.timestamps
    end
  end
end
