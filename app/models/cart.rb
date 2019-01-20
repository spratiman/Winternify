class Cart < ApplicationRecord
  validates :completed, :presence => true
end
