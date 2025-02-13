class CreateCartProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_products do |t|
      t.timestamps

      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
    end
  end
end
