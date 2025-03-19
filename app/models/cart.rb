class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  
  def total
    cart_items.sum { |item| item.product.price * item.quantity }
  end
  
  def add_product(product_id, quantity = 1)
    product = Product.find(product_id)
    current_item = cart_items.find_by(product_id: product_id)
    
    if current_item
      current_item.increment!(:quantity, quantity)
    else
      cart_items.create(product_id: product_id, quantity: quantity)
    end
  end
end
