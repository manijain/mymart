class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.order_items.group(:product_id).sum(:item_quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.order_items.where(product_id: product_id).delete_all

          # replace with a single item
          item = cart.order_items.build(product_id: product_id)
          item.item_quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items
    OrderItem.where("item_quantity>1").each do |order_item|
      # add individual items
      order_item.item_quantity.times do 
        OrderItem.create cart_id: order_item.cart_id,
          product_id: order_item.product_id
      end

      # remove original item
      order_item.destroy
    end
  end
end