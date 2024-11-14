class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category).search(params[:search])
  end

  def show
    @product = Product.find(params[:id])
  end

  def filter_by_category
    @categories = Category.all
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end
    render :index
  end
end
