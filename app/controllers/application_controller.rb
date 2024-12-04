class ApplicationController < ActionController::Base
  before_action :initalize_session
  helper_method :cart, :cart_quantity
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :street_address, :city, :postal_code) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :street_address, :city, :postal_code) }
  end

  private

  def initalize_session
    session[:cart] ||= {} # Will contain a hash with product_id as key and quantity as value
  end

  def cart
    session[:cart].map { |product_id, quantity| { product: Product.find(product_id), quantity: quantity } }
  end
end
