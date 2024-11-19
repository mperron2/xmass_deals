class ApplicationController < ActionController::Base
  before_action :initalize_session

  private
  def initalize_session
    session[:cart] ||= [] # Will contain a array of product_ids
  end
end
