class AddInitialProducts < ActiveRecord::Migration[5.2]
  def up
    Product.create(title: "Toronto Raptors T-Shirt", price: 35.0, inventory_count: 5, inStock: true)
  end

  def down
    Product.delete_all
  end
end
