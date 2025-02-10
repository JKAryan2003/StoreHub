class ProductStock < ApplicationRecord
  belongs_to :product

  enum transaction_type: {
    in: 0,
    out: 1 
  }

end
