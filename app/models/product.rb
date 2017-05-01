class Product < ActiveRecord::Base
  validates :title, :price, :quantity, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, numericality: {only_integer: true }
  validates :title, uniqueness: true
  has_attached_file :picture, :styles => { :small => "150x150>", :medium => "250x250>" }
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"], default_url: "/images/missing.png"
  # validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 8.megabytes
  self.per_page = 4
  has_many :order_items
  has_many :orders, through: :order_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    if order_items.empty?
      return true
    else
      errors.add(:base, 'Order Items present')
      return false
    end
  end
end