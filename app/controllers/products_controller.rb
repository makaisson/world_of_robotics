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
    @product = CreateProductWithCategoryService.new(
      params.require(:product).permit(:title, :description, :price),
      params.require(:category)[:id]
    ).create

    if @product.persisted?
      redirect_to admin_index_path
    else
      render :new
    end
  end
end
