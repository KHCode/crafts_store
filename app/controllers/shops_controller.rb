class ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    @shops = Shop.all
  end

  def show
    @products = @shop.products
  end

  def new
    if current_user.shop.present?
      redirect_to edit_shop_path(current_user.shop), notice: 'You already have a shop. You can edit it here.'
    else
      @shop = Shop.new
    end
  end

  def edit
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user

    if @shop.save
      redirect_to @shop, notice: 'Shop was successfully created.'
    else
      render :new
    end
  end

  def update
    if @shop.update(shop_params)
      redirect_to @shop, notice: 'Shop was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to shops_url, notice: 'Shop was successfully destroyed.'
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def ensure_owner
    unless @shop.user == current_user
      redirect_to shops_path, alert: "You don't have permission to modify this shop."
    end
  end

  def shop_params
    params.require(:shop).permit(:name, :description)
  end
end