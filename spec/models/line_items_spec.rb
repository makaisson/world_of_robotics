require "spec_helper"

describe LineItem do
  describe "Validations" do
    it { should belong_to(:product) }
    it { should belong_to(:cart) }
    it { should allow_mass_assignment_of(:quantity) }
  end

  describe "Quantity" do
    it "should default the quantity to 1" do
      line_item = FactoryGirl.create(:line_item)
      line_item.quantity.should == 1
    end
  end

  describe "#destroy_line_item" do
    let(:line_item) { FactoryGirl.create(:line_item) }

    context "the line item quantity is greater than 1" do
      it "should decrement the line item quantity" do
        line_item.quantity = 2
        line_item.destroy_line_item
        line_item.quantity.should == 1
      end
    end

    context "the line item quantity is 1" do
      it "should destroy the line_item" do
        line_item.quantity = 1
        line_item.destroy_line_item
        #TODO: WHY WONT YOU DIE? destroy_line_item appears to return destroy
        # without complaining. But line item doesn't go away. It also reports
        # it never received destroy.
        line_item.should_receive(:destroy)
      end
    end
  end
end
