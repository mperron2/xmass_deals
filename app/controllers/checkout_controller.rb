class CheckoutController < ApplicationController
  before_action :authenticate_customer!, only: [ :index, :confirm ]
  before_action :set_customer, only: [ :confirm ]

  def index
    @cart_items = cart
    @total_price = calculate_total(@cart_items)
  end

  def confirm
    @cart_items = cart
    @customer = current_customer
    @total_price = calculate_total(@cart_items)
    @province_tax_rate = get_tax_rate(@customer.province)
    @tax = @total_price * @province_tax_rate
    @grand_total = @total_price + @tax
  end

  def paid
    @customer = current_customer
    @cart_items = cart
    @total_price = calculate_total(@cart_items)

    @order = Order.create(
      customer: @customer,
      status: "Completed",
      cost: @total_price
    )

    @cart_items.each do |entry|
      OrderItem.create(
        order: @order,
        product: entry[:product],
        quantity: entry[:quantity],
        price: entry[:product].price
      )
    end

    session[:cart] = {}
  end

  def thankyou
    paid
    render "thankyou"
  end

  private

  def set_customer
    @customer = current_customer
  end

  def calculate_total(cart_items)
    cart_items.sum { |entry| entry[:product].price * entry[:quantity] }
  end

  def get_tax_rate(province)
    tax_rates = {
      "Alberta" => 0.05,
      "British Columbia" => 0.12,
      "Manitoba" => 0.12,
      "New Brunswick" => 0.15,
      "Newfoundland and Labrador" => 0.15,
      "Nova Scotia" => 0.15,
      "Ontario" => 0.13,
      "Prince Edward Island" => 0.15,
      "Quebec" => 0.14975,
      "Saskatchewan" => 0.06
    }
    tax_rates[province] || 0.15
  end
end
