class LineItemsController < ApplicationController
  def create
    cart    = current_cart
    service = AddLineItemService.new(cart, Product.find(params[:product_id]))

    if service.add
      redirect_to cart #need cart show page
    else
      redirect_to root_path #this should do something useful
    end
  end
end
