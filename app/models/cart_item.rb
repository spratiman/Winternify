class CartItem < ApplicationRecord
  has_many :products
  belongs_to :cart
  validates :product_id, :presence => true
  validates :cart_id, :presence => true
  validates :quantity, :presence => true
end
