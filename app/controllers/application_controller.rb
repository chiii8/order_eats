class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  
  def search
    @q = Store.ransack(params[:q])
    @store = @q.result(distinct: true).page(params[:page])
    @result = params[:q]&.values&.reject(&:blank?)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :gender, :birth_date, :name, :address])
  end
end
