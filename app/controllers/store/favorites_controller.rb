class Store::FavoritesController < ApplicationController
  def create
    store = Store.find(params[:store_id])
    favorite = current_customer.favorite.new(store_id: store.id)
    favorite.save
    redirect_to request.referer
  end
  
  def destroy
    store = Store.find(params[:store_id])
    favorite = current_customer.favorite.find_by(store_id: store.id)
    favorite.destroy
    redirect_to request.referer
  end
end
