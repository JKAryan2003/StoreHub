class Category < ApplicationRecord
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id"
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true
end
