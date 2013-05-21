require './app/services/add_line_item_service'

describe AddLineItemService do
  describe '#add' do
    let(:service)    { AddLineItemService.new cart, product }
    let(:cart)       { double 'Cart', :line_items => line_items }
    let(:line_items) { double 'Line Items', :build => line_item }
    let(:line_item)  { double 'Line Item', :product= => product, :save => true }
    let(:product)    { double 'Product', :id => 684 }

    before :each do
      stub_const 'Cart', double(:create => cart)
      stub_const 'Product', double(:find => product)
    end

    shared_examples_for 'item persistence' do
      it "saves the line item" do
        line_item.should_receive(:save).and_return(true)

        service.add
      end

      it "returns true when the line item saves" do
        service.add.should be_true
      end

      it "returns false when the line item fails to save" do
        line_item.stub :save => false
        
        service.add.should be_false
      end
    end

    context "with a new product for the cart" do
      before :each do
        line_items.stub :find_by_product_id => nil
      end

      it_should_behave_like 'item persistence'

      it "adds the product to the cart" do
        line_items.should_receive(:build).and_return(line_item)

        service.add
      end

      it "sets the product for the line item" do
        line_item.should_receive(:product=).with(product)

        service.add
      end
    end

    context "with an existing product in the cart" do
      before :each do
        line_items.stub :find_by_product_id => line_item
        line_item.stub :quantity => 1, :quantity= => 2
      end

      it_should_behave_like 'item persistence'

      it "increments the quantity of the product in the cart" do
        line_item.should_receive(:quantity=).with(2)

        service.add
      end
    end
  end
end
