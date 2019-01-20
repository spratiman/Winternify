class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.integer :inventory_count
      t.boolean :inStock
      t.decimal :price

      t.timestamps
    end
  end
end
