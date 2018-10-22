class FixShopUserRelation < ActiveRecord::Migration[5.0]
  def change
    remove_column :shops, :owner_id
    add_column :shops, :user_id, :string
  end
end
