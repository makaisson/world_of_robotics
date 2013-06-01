class Product < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :categorizations
  has_many :line_items
  has_many :categories, through: :categorizations

  monetize        :amount_in_cents, as: :price
  validates       :title, presence: true

  before_destroy :ensure_not_referenced_by_any_line_items

  def self.create_with_category(category_id, product_attributes)
    Product.transaction do
      product = Product.new(product_attributes)

      if product.save
        # explicity create the join table entry because magic is hard
        Categorization.create(
          product_id:  product.id,
          category_id: category_id
        )
      end

      product
    end
  end

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
