class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end
  
  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.update(quantity: cart_item.quantity)
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      puts @cart_item.errors.full_messages
      redirect_to cart_items_path
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "商品を更新しました。"
      redirect_to request.referer
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity, :store_id)
  end
end
