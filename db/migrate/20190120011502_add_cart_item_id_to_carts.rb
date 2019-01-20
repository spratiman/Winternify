class AddCartItemIdToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :cart_item_id, :integer
    add_index  :carts, :cart_item_id
  end
end
