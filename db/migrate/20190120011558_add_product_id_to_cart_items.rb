class AddProductIdToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :product_id, :integer
    add_index  :cart_items, :product_id
  end
end
