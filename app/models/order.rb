class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  # has_one :customer_addresses

  validates :name, :address, :email, presence: true
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]

  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      item.cart_id = nil
      order_items << item
    end
  end
end