class Store::ItemCategoriesController < ApplicationController
  before_action :authenticate_store!
  
  def index
    @item_category = ItemCategory.new
    @item_categories = ItemCategory.all.page(params[:page])
  end
  
  def edit
    @item_category = ItemCategory.find(params[:id])
  end
  
  def create
    @item_category = ItemCategory.new(item_category_params)
    if @item_category.save
      redirect_to store_item_categories_path
    else
      render :index
    end
  end
  
  def update
    item_category = ItemCategory.find(params[:id])
    if item_category.update(item_category_params)
      redirect_to store_item_categories_path
    else
      render :edit
    end
  end
  
  private
  
  def item_category_params
    params.require(:item_category).permit(:name)
  end
end
