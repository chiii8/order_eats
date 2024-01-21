class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :gender, :is_active)
  end
end
