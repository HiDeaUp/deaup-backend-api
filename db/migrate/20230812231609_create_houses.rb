class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :title, null: false
      t.text :description
      t.string :category, null: false
      t.string :address, null: false
      t.string :image, null: false
      t.float :price, null: false
      t.integer :bedroom, null: false
      t.integer :bathroom, null: false
      t.integer :car, null: false
      t.references :user, null: true
      t.timestamps
    end
  end
end
