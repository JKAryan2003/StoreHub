class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.timestamps

      t.string :name
      t.text :description
      t.float :price
      
    end
  end
end
