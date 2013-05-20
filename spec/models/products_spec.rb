require "spec_helper"

describe Product do
  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should have_many(:categories).through(:categorizations) }
    it { should have_many(:line_items) }
  end

  describe "Getting and setting price" do
    before :each do
      @product = FactoryGirl.build(:product)
    end

    context "#price" do
      it "should return the amount_in_cents as a Money object" do
        @product.amount_in_cents = 1234
        @product.price.should == Money.new("1234")
      end
    end

    context "#price=" do
      it "should set the amount_in_cents" do
        @product.price = 56.78
        @product.amount_in_cents.should == 5678
      end
    end
  end

  describe "#ensure_not_referenced_by_any_line_items" do
    context "line items reference the product" do
      it "should add an error to the model base"
      it "should return false"
    end

    context "not line items reference the product" do
      it "should return true"
    end
  end
end
