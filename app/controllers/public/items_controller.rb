class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  before_action :set_customer
  
  def index
    @items = @store.items.where(is_active: 1).page(params[:page]).per(8)
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :is_active, :store_id)
  end
  
  def set_customer
    @store = Store.find(params[:store_id])
  end
end
