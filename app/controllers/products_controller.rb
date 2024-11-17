class ProductsController < ApplicationController
  def index
    @categories = Category.all.presence || []
    @products = Product.all

    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
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
