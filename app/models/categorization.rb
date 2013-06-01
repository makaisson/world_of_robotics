class Categorization < ActiveRecord::Base
  belongs_to :product
  belongs_to :category

  attr_accessible :product_id, :category_id

  validates :product_id, :category_id, presence: true
end
