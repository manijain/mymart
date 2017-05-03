class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :customer_addresses, dependent: :destroy

  def is_admin?
    is_admin
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end