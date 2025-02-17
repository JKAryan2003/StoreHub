class DropOrderProduct < ActiveRecord::Migration[7.2]
  def change
    drop_table :order_products
  end
end
