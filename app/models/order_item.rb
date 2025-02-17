class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum :status, [
    :placed, :delivered, :shipped, :in_transit, :cancelled 
]
end