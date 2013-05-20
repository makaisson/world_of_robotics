class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])

    @line_item = @cart.line_items.build
    @line_item.product = product

    if @line_item.save
      redirect_to @line_item.cart #need cart show page
    else
      redirect_to home_path #this should do something useful
    end
  end
end
