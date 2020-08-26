class AddTokenToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :token, :string
    add_index :rentals, :token, unique: true
  end
end
