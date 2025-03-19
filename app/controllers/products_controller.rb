class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :ensure_shop_owner, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])
      @products = @category ? @category.products : Product.all
    else
      @products = Product.all
    end
    
    @products = @products.order(created_at: :desc)
  end

  def show
  end

  def new
    @shop = current_user.shop
    @product = @shop.products.build
  end

  def edit
  end

  def create
    @shop = current_user.shop
    @product = @shop.products.build(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def ensure_shop_owner
    unless @product.shop.user == current_user
      redirect_to products_path, alert: "You don't have permission to modify this product."
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :inventory_count, category_ids: [])
  end
end