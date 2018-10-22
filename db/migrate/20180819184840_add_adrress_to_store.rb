class AddAdrressToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :address, :string
  end
end
