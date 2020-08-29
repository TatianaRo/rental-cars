class CreateCarRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :car_rentals do |t|
      t.references :rental, foreign_key: true
      t.references :car, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.string :driver_license_number

      t.timestamps
    end
  end
end
