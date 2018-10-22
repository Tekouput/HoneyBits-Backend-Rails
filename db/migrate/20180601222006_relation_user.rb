class RelationUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :role_id
    end
  end
end
