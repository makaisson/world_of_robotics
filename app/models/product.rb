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
      product =  Product.new(product_attributes)
      category = Category.find_by_id(category_id)

      if category && product.save
        Categorization.create(
          product_id:  product.id,
          category_id: category_id
        )
      elsif !category
        product.errors.add(:categories, "Category is invalid")
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
