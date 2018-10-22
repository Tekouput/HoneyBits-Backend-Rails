class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :description
      t.string :profile_pic
      t.float :latitude
      t.float :longitude
      t.text :policy
      t.string :owner_id
      t.float :raiting

      t.timestamps
    end
  end
end
