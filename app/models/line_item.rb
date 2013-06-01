class LineItem < ActiveRecord::Base
  attr_accessible :quantity
  belongs_to :product
  belongs_to :cart
end
