class RemoveCartItemIdFromCarts < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :cart_item_id, :integer
  end
end
