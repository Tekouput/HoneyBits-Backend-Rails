class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :item_counts
      t.string :user_id
      t.string :address_id

      t.timestamps
    end
  end
end
