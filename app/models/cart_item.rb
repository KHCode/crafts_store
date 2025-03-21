class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def total_price
    product.price * quantity
  end
end
