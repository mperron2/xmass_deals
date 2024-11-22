class ApplicationController < ActionController::Base
  before_action :initalize_session
  helper_method :cart

  private
  def initalize_session
    session[:cart] ||= [] # Will contain a array of product_ids
  end
  def cart
    Product.find(session[:cart])
  end
end
