class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.find(params[:id])

    if @category.save
      redirect_to admin_index_path
    else
      render :new
    end
  end
end
