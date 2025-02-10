class Product < ApplicationRecord
  has_many_attached :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :product_stocks

  belongs_to :user
end
