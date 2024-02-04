class Store::ItemsController < ApplicationController
  before_action :authenticate_store!
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_store

  def index
    # カテゴリーがクリックされたとき、
    if params[:item_category_id].present?
      @item_category = ItemCategory.find(params[:item_category_id])
      @items = @item_category.items.page(params[:page]).per(12)
    else
      @items = @store.items.page(params[:page]).per(12)
    end
  end

  def new
    @item = Item.new
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
  end

  def edit
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
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :store_id, :item_category_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_store
    @store = current_store
  end
end
