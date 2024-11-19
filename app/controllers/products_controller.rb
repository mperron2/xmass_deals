class ProductsController < ApplicationController
  def index
    @categories = Category.all.presence || []
    @products = Product.all.order(price: :asc)

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
      @products = Product.where(category_id: params[:category_id]).order(price: :asc)
    else
      @products = Product.all.order(price: :asc)
    end

    respond_to do |format|
      format.js { render "filter_by_category" }
      format.html { render :index }
    end
  end
end
