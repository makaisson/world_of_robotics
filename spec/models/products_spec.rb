require "spec_helper"

describe Product do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should have_many(:categories).through(:categorizations) }
  end

  let(:product) { Product.new(title: "title") }

  describe "#price" do
    it "should return the amount_in_cents as a Money object" do
      product.amount_in_cents = 1234
      product.price.should == Money.new("1234")
    end
  end

  describe "#price=" do
    it "should set the amount_in_cents" do
      product.price = 56.78
      product.amount_in_cents.should == 5678
    end
  end
end
