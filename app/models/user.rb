# User model
class User < ApplicationRecord
  has_secure_password
  belongs_to :role, optional: true
  has_many :follows, as: :follower
  has_many :follows, as: :followed
  has_many :shops
  has_many :carts
  has_and_belongs_to_many :favorites, class_name: 'Shop'
  has_and_belongs_to_many :favorite_products, class_name: 'Product'

  has_attached_file :user_picture, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/honey.jpg"
  validates_attachment_content_type :user_picture, content_type: /\Aimage\/.*\z/

  def simple_info
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      profile_pic: profile_pic || user_picture.url(:medium) || '',
      sex: sex,
      birth_day: birthday,
      email: email,
      role: role_id,
      followers: Follow.where(followed_id: id).count,
      following: Follow.where(follower_id: id).count,
      favorites: favorites.count,
      date_joined: created_at
    }
  end
end
