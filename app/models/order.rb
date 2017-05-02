class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :customer_address, dependent: :destroy
  # validates :name, :address, :email, presence: true

  # PAYMENT_TYPES = ["Credit card", "Debit Card"]

  # validates :pay_type, inclusion: PAYMENT_TYPES

  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      # item.cart_id = nil
      self.order_items << item
    end
  end

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
end