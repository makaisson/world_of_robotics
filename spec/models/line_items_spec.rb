require "spec_helper"

describe LineItem do
  describe "Validations" do
    it { should belong_to(:product) }
    it { should belong_to(:cart) }
  end

  describe "Quantity" do
    it "should default the quantity to 1" do
      line_item = FactoryGirl.create(:line_item)
      line_item.quantity.should == 1
    end
  end
end
