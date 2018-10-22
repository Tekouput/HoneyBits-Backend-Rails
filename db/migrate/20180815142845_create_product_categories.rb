class CreateProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_products do |t|
      t.references :category
      t.references :product

      t.timestamps
    end
  end
end
