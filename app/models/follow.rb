class Follow < ApplicationRecord
  belongs_to :user, polymorphic: true


  def simple_info
    {
      follower: follower_id,
      followed: followed_id,
      date: created_at
    }
  end

  def users_info
    {
      follower: follower.simple_info,
      followed: followed.simple_info
    }
  end

end
