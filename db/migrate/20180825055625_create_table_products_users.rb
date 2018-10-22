class CreateTableProductsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :products_users do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
