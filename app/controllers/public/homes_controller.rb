class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top]
  
  def top
    @stores = Store.all
  end
end
