class CartController < ApplicationController
  before_action :get_product, only: %i[create destroy]

  def create
    product_id = @product.id.to_s
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    redirect_to root_path
  end

  def destroy
    product_id = @product.id.to_s
    session[:cart].delete(product_id)
    redirect_to request.referer || root_path
  end


  def update_quantity
    product_id = params[:id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity if quantity > 0
    redirect_to request.referer || root_path
  end

  def cart
    session[:cart]&.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      { product: product, quantity: quantity }
    end.compact || []
  end

  private

  def get_product
    product_id = params[:id]
    @product = Product.find_by(id: product_id)

    unless @product
      redirect_to root_path, alert: "Product not found"
    end
  end
end
