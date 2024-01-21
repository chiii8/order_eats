class Public::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :maypage, :confirmation, :favorites, :edit, :update, :withdraw]
  
  def show
  end
  
  def mypage
  end
  
  def confirmation
  end
  
  def favorites
    favorites = Favorite.where(customer_id: @customer.id).pluck(:store_id)
    @favorite_stores = Store.find(favorites)
  end
  
  def edit
  end
  
  def update
    if params[:id] == "withdraw" # idがwithdrawか否か判別する
      withdraw
    elsif @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to confirmation_path(current_customer)
    else
      render :edit
    end
  end
  
  def withdraw_confirm
  end
  
  def withdraw
    if @customer.update(is_active: false)
      reset_session
    end
      flash[:notice] = "またのご利用をお待ちしております。"
      redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :is_active, :email, :profile_image, :gender)
  end
  
  def set_customer
    @customer = current_customer
  end
end
