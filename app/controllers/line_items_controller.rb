class LineItemsController < ApplicationController
  def create
    cart    = current_cart
    service = AddLineItemService.new(cart, Product.find(params[:product_id]))

    if service.add
      redirect_to cart
    else
      #TODO this should do something useful
      redirect_to root_path
    end
  end

  def destroy
    line_item = LineItem.find(params[:id])
    cart      = current_cart

    line_item.destroy_line_item

    if cart.line_items.empty?
      redirect_to products_path
    else
      redirect_to cart
    end
  end
end
