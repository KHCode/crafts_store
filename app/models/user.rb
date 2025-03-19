class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true
  
  has_one :shop, dependent: :destroy
  has_one :cart, dependent: :destroy
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # Ensure user always has a cart
  def cart
    super || create_cart
  end
end
