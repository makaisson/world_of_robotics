class LineItem < ActiveRecord::Base
  attr_accessible :quantity
  belongs_to :product
  belongs_to :cart

  def destroy_line_item
    # TODO: There is a race condition here.
    if quantity > 1
      # TODO: figure out why self was required here? I am using it as an
      #  argument, not inside a method or some other shit.
      update_attributes!(quantity: self.quantity -= 1)
    else
      destroy
    end
  end
end


