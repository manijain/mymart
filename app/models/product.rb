class Product < ActiveRecord::Base
  validates :title, :price, :quantity, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:min => 0, :max => 1000000}
  validates :quantity, numericality: {only_integer: true }

  has_attached_file :picture, :styles => { :small => "150x150>" }
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 8.megabytes
  self.per_page = 4
  has_many :order_items
end
