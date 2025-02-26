class AddDefaultToAddress < ActiveRecord::Migration[7.2]
  def change
    change_column_default :addresses, :default_address, false
  end
end
