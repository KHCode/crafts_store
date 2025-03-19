class AccountsController < ApplicationController
  def home
    @featured_products = Product.order(created_at: :desc).limit(4)
    @featured_shops = Shop.order(created_at: :desc).limit(3)
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account
    else
      render 'new'
    end
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end
end
