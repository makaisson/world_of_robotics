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

    context "no cart exists" do
      before :each do
        session[:cart_id] = nil
      end

      it "creates a new cart" do
        Cart.should_receive(:create).and_return(cart)

        post :create, :product_id => 678
      end

      it "saves the cart to the session" do
        post :create, :product_id => 678

        session[:cart_id].should == cart.id
      end
    end

    context "cart exists in the session" do
      before :each do
        session[:cart_id] = cart.id
      end

      it "loads the existing cart" do
        Cart.should_receive(:find).with(cart.id).and_return(cart)

        post :create, :product_id => 678
      end
    end

    context "card id exists but is not in the database" do
      before :each do
        session[:cart_id] = 432

        Cart.stub :find => nil
      end

      it "creates a new cart" do
        Cart.should_receive(:create).and_return(cart)

        post :create, :product_id => 678
      end

      it "saves the cart to the session" do
        post :create, :product_id => 678

        session[:cart_id].should == cart.id
      end
    end
  end
end
