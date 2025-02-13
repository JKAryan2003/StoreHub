class AddQuantityToCartProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :cart_products, :quantity, :integer
  end
end
