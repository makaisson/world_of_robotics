class Product < ActiveRecord::Base
  has_many :categorizations
  has_many :line_items
  has_many :categories, through: :categorizations

  attr_accessible :title, :description, :price
  monetize        :amount_in_cents, as: :price
  validates       :title, presence: true

  before_destroy :ensure_not_referenced_by_any_line_items

  private

  def ensure_not_referenced_by_any_line_items
    if line_items.empty?
      true
    else
      errors.add(:base, "line items present")
      false
    end
  end
end
