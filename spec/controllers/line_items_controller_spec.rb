require "spec_helper"

describe LineItemsController do
  describe "#create" do
    let(:cart)    { mock_model Cart }
    let(:product) { double 'Product' }
    let(:service) { double 'Add Line', :add => true }

    before :each do
      Cart.stub :create => cart
      stub_const 'Product', double(:find => product)
      stub_const 'AddLineItemService', double(:new => service)
    end

    it "creates a service with the current cart and product" do
      AddLineItemService.should_receive(:new).with(cart, product)

      post :create, :product_id => 487
    end

    it "adds the line item" do
      service.should_receive(:add).and_return(true)

      post :create, :product_id => 487
    end

    it "should redirect to the cart upon success" do
      post :create, :product_id => 487

      response.should redirect_to(cart_path(cart)) 
    end

    it "should redirect to home upon failure" do
      service.stub(:add => false)

      post :create, :product_id => 487 

      response.should redirect_to(root_path)
    end
  end
end
