class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.timestamps

      t.integer :quantity
      t.references :user, null: false, foreign_key: true
    end
  end
end
