class HoneyBitsUserAttrs < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :phone_number
      t.string :stripe_id
      t.integer :bees
    end
  end
end
