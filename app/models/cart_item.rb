class CartItem < ApplicationRecord
  has_many :products
  belongs_to :cart
end
