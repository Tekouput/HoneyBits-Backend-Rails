class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :user_id
      t.string :zip_code
      t.string :primary_address
      t.string :secondary_address
      t.string :side_note

      t.timestamps
    end
  end
end
