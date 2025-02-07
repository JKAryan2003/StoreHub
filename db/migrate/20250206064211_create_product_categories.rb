class CreateProductCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :product_categories do |t|
      t.timestamps

      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
    end
  end
end
