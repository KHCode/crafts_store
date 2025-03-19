class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product)
  end
  
  def clear
    current_user.cart.cart_items.destroy_all
    redirect_to cart_path, notice: 'Your cart has been cleared.'
  end
end