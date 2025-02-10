class Product < ApplicationRecord
  has_many_attached :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :product_stocks

  belongs_to :user

  def self.search(search)
    if search
      product = Product.find_by(name: search)

      if product
        self.product
      else
        @search_products = Product.all
      end
    else
      @search_products = Product.all
    end
  end
end
