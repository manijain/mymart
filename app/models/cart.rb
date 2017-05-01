class Cart < ActiveRecord::Base
  has_many :order_items
  belongs_to :customer

  def add_product(product_id)
    current_item = order_items.find_by_product_id(product_id)
    if current_item
      current_item.item_quantity += 1
    else
      current_item = order_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
end