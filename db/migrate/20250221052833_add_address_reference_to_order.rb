class AddAddressReferenceToOrder < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :address, null: false, foreign_key: true
  end
end
