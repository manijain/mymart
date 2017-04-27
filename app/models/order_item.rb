class OrderItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :order

  def total_price
    product.price * item_quantity
  end
end
