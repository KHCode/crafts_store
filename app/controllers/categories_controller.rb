class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all.order(:name)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    if @category.products.any?
      redirect_to categories_path, alert: 'Cannot delete a category that has associated products.'
    else
      @category.destroy
      redirect_to categories_path, notice: 'Category was successfully destroyed.'
    end
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end