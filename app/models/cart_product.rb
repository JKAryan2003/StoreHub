class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  
  validates :quantity, numericality: true
end
