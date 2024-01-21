class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order.fee = 300
  end
  
  def create
    # 注文を作成
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #@order.store_name = params[:order][:store_name]
    @order.save
    # 注文番号を設定
    number = Order.maximum(:number)
    if number.nil?
      @order.number = "M1"
    else
      @order.number = "M#{number.to_i + 1}"
    end
    @order.save
    #注文詳細を作成
    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.item_id = cart_item.item.id
      @order_details.quantity = cart_item.quantity
      @order_details.payment_amount = cart_item.item.with_tax_price
      @order_details.order_id = @order.id
      @order_details.number = @order.number
      @order_details.save
    end
    
    current_customer.cart_items.destroy_all
    redirect_to possible_path(order_id: @order.id)
  end
  
  def index
    @orders = current_customer.orders.all
  end
  
  def possible
    @order = Order.find(params[:order_id])
  end
  
  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(:fee, :customer_id, :payment_method, :payment_amount)
  end
end
