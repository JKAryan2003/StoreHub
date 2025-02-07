class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.timestamps

      t.string :name
      t.text :description
    end
  end
end
