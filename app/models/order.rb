class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :customer_addresses
end
