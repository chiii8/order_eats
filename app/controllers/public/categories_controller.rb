class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer!
  
  def category
    @category_id = params[:category_id]
    @items = Item.where(category_id: @category_id)
    @categories = Category.all
  end
end
