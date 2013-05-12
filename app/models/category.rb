class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :products, through: :categorizations

  attr_accessible :title, :description
  validates       :title, presence: true
end
