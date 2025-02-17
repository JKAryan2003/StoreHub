class Product < ApplicationRecord
  has_many_attached :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :product_stocks, dependent: :destroy

  has_many :cart_products
  has_many :carts, through: :cart_products
  belongs_to :user

  has_many :order_items, dependent: :destroy
end
