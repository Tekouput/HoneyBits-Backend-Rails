class Billing < ApplicationRecord
  belongs_to :cart
  belongs_to :user
end
