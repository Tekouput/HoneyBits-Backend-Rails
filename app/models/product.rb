class Product < ApplicationRecord
  has_and_belongs_to_many :carts, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  belongs_to :shop
  belongs_to :user
  has_many :product_images, dependent: :destroy

  def self.create_product(params, categories = [], user_id)
    product = Product.new params
    product.append_categories categories
    product.set_user user_id
    product.save!
    product
  end

  def append_categories(categories)
    self.categories = categories
  end

  def set_user(user_id)
    self.user_id = user_id
  end

  def simple_info(fan = nil)
    {
      id: id,
      name: name,
      description: description,
      categories: categories.map(&:name),
      price: {
        raw: "#{price}",
        formatted: number_to_currency(price.to_f)
      },
      shop: shop.simple_info,
      pictures: product_images.map(&:simple_info),
      is_favorite: fan ? (fan.favorite_products.include? self) : false
    }
  end

  def feed_view(type)
    simple_info.merge!(user_relaton: type)
  end

end
