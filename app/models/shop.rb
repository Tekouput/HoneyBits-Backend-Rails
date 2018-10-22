class Shop < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :users
  alias_attribute :fans, :users
  has_many :products

  has_attached_file :shop_picture, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/honey.jpg"
  validates_attachment_content_type :shop_picture, content_type: /\Aimage\/.*\z/

  has_attached_file :shop_logo, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/honey.jpg"
  validates_attachment_content_type :shop_logo, content_type: /\Aimage\/.*\z/

  def simple_info(user = nil)
    {
      id: id,
      name: name,
      description: description,
      shop_picture: {
        big: shop_picture.url(:big),
        medium: shop_picture.url(:medium),
        thumb: shop_picture.url(:thumb)
      },
      shop_logo: {
        big: shop_logo.url(:big),
        medium: shop_logo.url(:medium),
        thumb: shop_logo.url(:thumb)
      },
      map_location: {
        latitude: latitude.presence || 0,
        longitude: longitude.presence || 0,
        place_id: place_id.presence || '0'
      },
      policy: policy,
      raiting: raiting.presence || 0,
      sales_count: sales_count,
      is_favorite: user ? (user.favorites.include? self) : false
    }
  end

  def listing_info()

    image_array = []
    p_images = products.order(created_at: :desc).limit(3).map(&:product_images)
    for product_images in p_images
      for pictures in product_images
        image_array << pictures.picture.url(:thumb)
      end
    end

    {
      id: id,
      name: name,
      description: description,
      map_location: {
        latitude: latitude,
        longitude: longitude,
        place_id: place_id
      },
      logo_thumb: shop_logo.url(:thumb),
      products_picture: image_array
    }
  end

end
