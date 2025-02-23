class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum :status, [
    :placed, :confirmed, :delivered, :shipped, :in_transit, :cancelled 
]

end