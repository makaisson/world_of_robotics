class Product < ActiveRecord::Base
  has_many :categorizations
  has_many :line_items
  has_many :categories, through: :categorizations

  attr_accessible :title, :description
  monetize        :amount_in_cents, as: :price
  validates       :title, presence: true
end
