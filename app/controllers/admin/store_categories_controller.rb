class Admin::StoreCategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @store_category = StoreCategory.new
    @store_categories = StoreCategory.all
  end
  
  def edit
    @store_category = StoreCategory.find(params[:id])
  end
  
  def create
    @store_category = StoreCategory.new(store_category_params)
    if @store_category.save
      redirect_to admin_store_categories_path
    else
      render :index
    end
  end
  
  def update
    store_category = StoreCategory.find(params[:id])
    if store_category.update(store_category_params)
      redirect_to admin_store_categories_path
    else
      render :edit
    end
  end
  
  private
  
  def store_category_params
    params.require(:store_category).permit(:name)
  end
end
