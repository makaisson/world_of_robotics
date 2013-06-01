class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create_with_category(
      params[:category][:id],
      params[:product],
    )

    if @product.persisted?
      redirect_to admin_index_path
    else
      render :new
    end
  end
end
