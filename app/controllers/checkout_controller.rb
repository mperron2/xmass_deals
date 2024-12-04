class CheckoutController < ApplicationController
  before_action :authenticate_customer!, only: [ :index ]

  def index
    @cart_items = cart
  end

  def confirm
    redirect_to root_path
  end
end
