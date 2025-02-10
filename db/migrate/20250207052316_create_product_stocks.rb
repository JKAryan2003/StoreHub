class CreateProductStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :product_stocks do |t|
      t.timestamps

      t.integer :quantity
      t.boolean :transaction_type

      t.references :product, null: false, foreign_key: true
    end
  end
end