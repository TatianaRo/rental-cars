class CreateCostumers < ActiveRecord::Migration[5.2]
  def change
    create_table :costumers do |t|
      t.string :name
      t.string :document
      t.string :email

      t.timestamps
    end
  end
end
