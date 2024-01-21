class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top]
  
  def top
    @stores = Store.page(params[:page])
  end
end
