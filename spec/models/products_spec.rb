require "spec_helper"

describe Product do
  it { should validate_presence_of(:title) }

  let(:product) { Product.new(title: "title") }

  describe "#price" do
    it "should return the amount_in_cents in dollars" do
      product.amount_in_cents = 1234
      product.price.should == 12.34
    end
  end

  describe "#price=" do
    it "should set the amount_in_cents" do
      product.price = 56.78
      product.amount_in_cents.should == 5678
    end
  end
end
