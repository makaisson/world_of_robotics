require 'spec_helper'

describe CreateProductWithCategoryService do
  describe "#create" do
    let(:category) { FactoryGirl.create(:category) }
    let(:product_attributes) {
      FactoryGirl.attributes_for(:product).slice(:title, :description).merge(
        price: 10
      )
    }
    context "valid product attributes and cateogry id exists" do
      it "saves the product and associates it with a category" do
        product = CreateProductWithCategoryService.create(
          product_attributes,
          category.id
        )
        product.should be_persisted
        product.categories.should == [category]
      end
    end

    context "product attributes are invalid" do
      it "returns an unsaved product with errors" do
        product = CreateProductWithCategoryService.create(
          {},
          category.id
        )

        product.should_not be_persisted
        product.errors.should_not be_empty
      end
    end

    context "category id doesn't exist" do
      it "returns an unsaved product with errors" do
        product = CreateProductWithCategoryService.create(
          product_attributes,
          category.id + 1
        )
        product.should_not be_persisted
        product.errors.should_not be_empty
      end
    end
  end
end
