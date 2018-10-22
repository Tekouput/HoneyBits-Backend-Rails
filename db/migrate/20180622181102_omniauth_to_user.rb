class OmniauthToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :uuid
      t.string :provider
      t.string :profile_pic
    end
  end
end
