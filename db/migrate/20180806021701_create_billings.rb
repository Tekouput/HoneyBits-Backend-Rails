class CreateBillings < ActiveRecord::Migration[5.0]
  def change
    create_table :billings do |t|
      t.string :cart_id
      t.decimal :amount, precision: 10, scale: 6
      t.string :user_id
      t.float :cut_percentage

      t.timestamps
    end
  end
end
