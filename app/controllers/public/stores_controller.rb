class Public::StoresController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def index
    @store_categories = StoreCategory.all
    if params[:store_category_id].present?
      @store_category = StoreCategory.find(params[:store_category_id])
      @stores = @store_category.stores.page(params[:page])
    else
      @stores = Store.page(params[:page])
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :telephone_number, :address, :email, :image, :store_category_id)
  end
end
