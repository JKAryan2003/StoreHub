class Address < ApplicationRecord
  belongs_to :user

  has_many :orders, dependent: :nullify
end
