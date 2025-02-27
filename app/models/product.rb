class Product < ApplicationRecord
  paginates_per 2

  has_many_attached :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :product_stocks, dependent: :destroy

  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products
  belongs_to :user

  has_many :order_items, dependent: :destroy

  def check_product_stock

    product_stocks.where(transaction_type: "in").pluck(:quantity).sum - 
		product_stocks.where(transaction_type: "out").pluck(:quantity).sum 

  end
end
