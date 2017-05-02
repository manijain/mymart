class CustomerAddress < ActiveRecord::Base
  validates :address1, :city, :district, :state, :country, :pincode, :contact_details, presence: true
  belongs_to :order
  belongs_to :customer

  COUNTRIES = ["Angola, Argentina, Armenia","Belgium", "Belize", "Benin", "Canada", "Cabo Verde", "India", "Japan", "Russia", "Paris"]
end