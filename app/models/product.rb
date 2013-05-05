class Product < ActiveRecord::Base
  attr_accessible :title, :description
  monetize        :amount_in_cents, as: :price
  validates       :title, presence: true
end
