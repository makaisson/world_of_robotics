class AddLineItemService
  def initialize(cart, product)
    @cart, @product = cart, product
  end

  def add
    current_item ||= cart.line_items.find_by_product_id(product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = cart.line_items.build
      current_item.product = product
    end

    current_item.save
  end

  private

  attr_reader :cart, :product
end
