class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.string :follower_id
      t.string :followed_id

      t.timestamps
    end
  end
end


