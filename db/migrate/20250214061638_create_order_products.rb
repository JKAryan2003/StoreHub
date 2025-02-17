class CreateOrderProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :order_products do |t|
      t.timestamps

      t.integer :quantity
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

    end
  end
end
