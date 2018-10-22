class ProductImage < ApplicationRecord
  belongs_to :product

  has_attached_file :picture, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/honey.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def simple_info
    {
      id: id,
      product: product.id,
      urls: {
        big: picture.url(:big),
        medium: picture.url(:medium),
        thumb: picture.url(:thumb)
      }
    }
  end

end
