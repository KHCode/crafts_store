class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]
  
  def create
    @cart = current_user.cart
    @cart.add_product(params[:product_id], params[:quantity].to_i)
    
    redirect_to cart_path, notice: 'Product added to cart.'
  end
  
  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart updated successfully.'
    else
      redirect_to cart_path, alert: 'Failed to update cart.'
    end
  end
  
  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end
  
  private
  
  def set_cart_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end