class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.includes(:order_items, :products)
  end
end
