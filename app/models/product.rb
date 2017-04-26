class Product < ActiveRecord::Base
  has_attached_file :picture, :styles => { :small => "150x150>" }
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 8.megabytes
  self.per_page = 4
end
