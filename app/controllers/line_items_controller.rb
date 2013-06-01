class LineItemsController < ApplicationController
  def create
    cart    = current_cart
    service = AddLineItemService.new(cart, Product.find(params[:product_id]))

    if service.add
      redirect_to cart
    else
      redirect_to root_path #this should do something useful
    end
  end

  def destroy
    line_item = LineItem.find(params[:id])
    cart      = current_cart

    if line_item.quantity > 1
      line_item.update_attributes(quantity: line_item.quantity -= 1)
    else
      line_item.destroy
    end

    if current_cart.line_items.empty?
      redirect_to products_path
    else
      redirect_to cart
    end
  end
end
