class Store::ItemsController < ApplicationController
  before_action :authenticate_store!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @store = current_store
    @items = @store.items
  end

  def new
    @item = Item.new
    @store = current_store
  end

  def create
    @item = Item.new(item_params)
    @item.store_id = current_store.id
    if @item.save
      flash[:notice] = "メニューを追加しました。"
      redirect_to store_store_items_path
    else
      render :new
    end
  end

  def show
    @store = current_store
  end

  def edit
    @store = current_store
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "メニューを編集しました。"
      redirect_to store_store_items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :store_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
