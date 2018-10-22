class Cart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products
  belongs_to :address, optional: true

  def simple_info
    {
      products: products.map(&:simple_info),
      address: address.try(:simple_info)
    }
  end

end
