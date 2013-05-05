class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price

  validates :title, presence: true

  def price
    amount_in_cents.to_d / 100.00 if amount_in_cents
  end

  def price=(amount)
    self.amount_in_cents = amount.to_d * 100.00 if amount.present?
  end
end
