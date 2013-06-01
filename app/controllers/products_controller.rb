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
    @product = Product.new(params[:product])

    # QUESTION not sure how to do nice error handling
    if @product.save
      # explicity create the join table entry because magic is hard
      Categorization.create(
        product_id: @product.id,
        category_id: params[:category][:id]
      )
      redirect_to admin_index_path
    else
      render :new
    end
  end
end
