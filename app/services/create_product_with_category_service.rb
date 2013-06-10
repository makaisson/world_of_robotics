class CreateProductWithCategoryService
  def initialize(product_attributes, category_id)
    @product_attributes, @category_id = product_attributes, category_id
  end

  def create
    #TODO: figure out how to white list these attributes
    product = Product.new(@product_attributes)
    category = Category.find_by_id(@category_id)

    if category && product.save
      Categorization.create(product_id: product.id, category_id: category.id)
    elsif !category
      product.errors.add(:categories, "Category is invalid")
    end

    product
  end

  private

  attr_reader :product_params, :category_id
end
