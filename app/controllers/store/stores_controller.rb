class Store::StoresController < ApplicationController
  before_action :authenticate_store!
  before_action :set_store, only: [:show, :edit, :update]
  
  def show
  end
  
  def edit
  end
  
  def update
    if @store.update(store_params)
      redirect_to store_store_path(@store)
    else
      render :edit
    end
  end
  private
  
  def store_params
    params.require(:store).permit(:email, :password, :telephone_number, :image, :name, :address)
  end
  
  def set_store
    @store = Store.find(params[:id])
  end
end
