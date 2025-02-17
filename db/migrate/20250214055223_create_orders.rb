class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.timestamps

      t.integer :order_status
      t.integer :payment_status
      t.integer :quantity
      t.float :price

      t.references :user, null: false, foreign_key: true
    end
  end
end
